# PAPT (Problema de Alocacao de Professores a Turmas) - Julia/JuMP/CPLEX.
# Instancias JSON em ./instancias; resultados e modelos LP em ./resultados.
# Esta versao mantem a funcao objetivo ponderada do modelo anterior.

using JuMP
using CPLEX
using JSON

const DIRETORIO_INSTANCIAS = joinpath(@__DIR__, "instancias")
const DIRETORIO_RESULTADOS = joinpath(@__DIR__, "resultados")

# Pesos da formulacao ponderada atual (nao equivalem ao modelo lexicografico do PDF).
const ALPHA_F = 0.60
const ALPHA_S = 0.20
const ALPHA_C = 0.10
const ALPHA_G = 0.10

# Os valores podem ser sobrescritos por argumentos da linha de comando.
const TEMPO_LIMITE_PADRAO_SEGUNDOS = 3600.0
const GAP_RELATIVO_ALVO_PADRAO = 0.01
const THREADS_PADRAO = 1

function hora_valida(horario::String)
    return occursin(r"^(?:[01][0-9]|2[0-3]):[0-5][0-9]$", horario)
end

function minutos_do_dia(horario::String)::Int
    h, m = parse.(Int, split(horario, ":"))
    return 60 * h + m
end

function intervalos_sobrepoem(a, b)
    # Tupla: (dia, inicio_em_minutos, fim_em_minutos_ou_nothing).
    a[1] == b[1] || return false
    if a[3] === nothing || b[3] === nothing
        # Compatibilidade com instancias baseadas em slots discretos sem hora final.
        return a[2] == b[2]
    end
    # Intervalos semiabertos: [inicio, fim); encontros consecutivos nao conflitam.
    return a[2] < b[3] && b[2] < a[3]
end

function carregar_instancia(caminho::AbstractString)
    isfile(caminho) || error("Arquivo JSON nao encontrado: $(caminho)")
    dados = JSON.parsefile(caminho)

    for chave in ("professores", "turmas", "turnos_semanais", "pares_professor_turma")
        haskey(dados, chave) || error("Campo obrigatorio ausente no JSON: '$(chave)'.")
    end

    professores = dados["professores"]
    turmas = dados["turmas"]
    isempty(professores) && error("A instancia precisa conter pelo menos um professor.")
    isempty(turmas) && error("A instancia precisa conter pelo menos uma turma.")
    dados["turnos_semanais"] isa Vector || error("'turnos_semanais' precisa ser uma lista.")
    dados["pares_professor_turma"] isa Vector || error("'pares_professor_turma' precisa ser uma lista.")

    P = [String(p["id"]) for p in professores]
    T = [String(t["id"]) for t in turmas]
    R = String.(dados["turnos_semanais"])

    length(unique(P)) == length(P) || error("Existem IDs de professores duplicados.")
    length(unique(T)) == length(T) || error("Existem IDs de turmas duplicados.")
    length(unique(R)) == length(R) || error("Existem turnos semanais duplicados.")

    nome_professor = Dict(String(p["id"]) => String(p["nome"]) for p in professores)
    P_L = [String(p["id"]) for p in professores if get(p, "afastado", false) == true]
    P_ativos = setdiff(P, P_L)

    turma_por_id = Dict(String(t["id"]) => t for t in turmas)
    for j in T
        t = turma_por_id[j]
        for campo in ("disciplina", "horas", "slots")
            haskey(t, campo) || error("A turma $(j) nao tem o campo '$(campo)'.")
        end
        t["slots"] isa Vector || error("'slots' da turma $(j) precisa ser uma lista.")
        isempty(t["slots"]) && error("A turma $(j) precisa ter pelo menos um slot.")
        Float64(t["horas"]) > 0 || error("A carga horaria da turma $(j) deve ser positiva.")
    end

    K = sort(unique([String(turma_por_id[j]["disciplina"]) for j in T]))
    disciplina = Dict(j => String(turma_por_id[j]["disciplina"]) for j in T)
    horas = Dict(j => Float64(turma_por_id[j]["horas"]) for j in T)
    slots = Dict{String,Vector{Tuple{String,String}}}()
    intervalos_slots = Dict{String,Vector{Tuple{String,Int,Union{Nothing,Int}}}}()
    turnos = Dict{String,Vector{String}}()
    turnos_usados = Set{String}()
    slots_sem_hora_fim = 0

    for j in T
        slots[j] = Tuple{String,String}[]
        intervalos_slots[j] = Tuple{String,Int,Union{Nothing,Int}}[]
        turnos[j] = String[]
        slots_turma_vistos = Set{Tuple{String,String}}()
        for s in turma_por_id[j]["slots"]
            for campo in ("dia", "horario", "turno")
                haskey(s, campo) || error("Slot incompleto da turma $(j): campo '$(campo)' ausente.")
            end
            dia = String(s["dia"])
            horario = String(s["horario"])
            turno = String(s["turno"])
            hora_valida(horario) || error("Horario deve estar no formato HH:MM em $(j): $(horario).")
            turno in R || error("Turno '$(turno)' da turma $(j) nao esta em 'turnos_semanais'.")
            occursin("-", turno) || error("Turno invalido '$(turno)' na turma $(j).")
            first(split(turno, "-")) == dia || error("Dia do slot difere do dia do turno em $(j): $(dia), $(turno).")
            chave_slot = (dia, horario)
            chave_slot in slots_turma_vistos && error("Slot duplicado $(dia) $(horario) na turma $(j).")
            push!(slots_turma_vistos, chave_slot)
            push!(slots[j], chave_slot)
            inicio_min = minutos_do_dia(horario)
            fim_min = nothing
            if haskey(s, "horario_fim") && s["horario_fim"] !== nothing && !isempty(String(s["horario_fim"]))
                horario_fim = String(s["horario_fim"])
                hora_valida(horario_fim) || error("Horario final deve usar HH:MM em $(j): $(horario_fim).")
                fim_min = minutos_do_dia(horario_fim)
                fim_min > inicio_min || error("Horario final precisa ser posterior ao inicial em $(j): $(horario), $(horario_fim).")
            else
                slots_sem_hora_fim += 1
            end
            push!(intervalos_slots[j], (dia, inicio_min, fim_min))
            push!(turnos[j], turno)
            push!(turnos_usados, turno)
        end
        unique!(turnos[j])
    end

    Set(R) == turnos_usados || error(
        "'turnos_semanais' precisa corresponder exatamente aos turnos usados nas turmas. " *
        "Usados=$(sort(collect(turnos_usados))); informados=$(R)."
    )
    S = unique([slot for j in T for slot in slots[j]])

    # Pares de turmas com encontros que se sobrepoem. Para JSONs antigos sem
    # horario_fim, a regra permanece a igualdade exata de (dia, horario).
    pares_conflito = Tuple{String,String}[]
    for a in 1:length(T)-1, b in a+1:length(T)
        j1, j2 = T[a], T[b]
        conflitam = any(
            intervalos_sobrepoem(s1, s2)
            for s1 in intervalos_slots[j1] for s2 in intervalos_slots[j2]
        )
        conflitam && push!(pares_conflito, (j1, j2))
    end

    h_min = Dict{String,Float64}()
    h_max = Dict{String,Float64}()
    for p in professores
        i = String(p["id"])
        for campo in ("carga_min", "carga_max")
            haskey(p, campo) || error("O professor $(i) nao tem '$(campo)'.")
        end
        h_min[i] = Float64(p["carga_min"])
        h_max[i] = Float64(p["carga_max"])
        h_min[i] >= 0 || error("A carga minima de $(i) nao pode ser negativa.")
        h_max[i] >= h_min[i] || error("A carga maxima de $(i) e menor que a minima.")
    end

    # Pares nao listados sao inelegiveis. e[i,j] = qualificado AND disponivel.
    e = Dict{Tuple{String,String},Int}((i,j) => 0 for i in P for j in T)
    w = Dict{Tuple{String,String},Float64}((i,j) => 0.0 for i in P for j in T)
    pares_vistos = Set{Tuple{String,String}}()

    for par in dados["pares_professor_turma"]
        for campo in ("professor", "turma", "qualificado", "disponivel", "preferencia")
            haskey(par, campo) || error("Registro de par professor-turma sem campo '$(campo)'.")
        end
        i = String(par["professor"])
        j = String(par["turma"])
        i in P || error("O par professor-turma referencia professor desconhecido: $(i).")
        j in T || error("O par professor-turma referencia turma desconhecida: $(j).")
        chave = (i,j)
        chave in pares_vistos && error("Par professor-turma duplicado: $(i), $(j).")
        push!(pares_vistos, chave)

        q = Bool(par["qualificado"])
        a = Bool(par["disponivel"])
        pref = Float64(par["preferencia"])
        0.0 <= pref <= 5.0 || error("Preferencia fora da escala [0,5] no par $(i), $(j).")
        isapprox(pref, round(pref)) || error("As preferencias devem ser inteiras de 0 a 5 porque s_min e inteiro no modelo atual.")
        e[chave] = (q && a && !(i in P_L)) ? 1 : 0
        w[chave] = e[chave] == 1 ? pref : 0.0
    end

    id_instancia = String(get(dados, "id", splitext(basename(caminho))[1]))
    descricao = String(get(dados, "descricao", "Sem descricao"))

    return (
        id=id_instancia, descricao=descricao,
        P=P, T=T, K=K, P_L=P_L, P_ativos=P_ativos, R=R, S=S,
        nome_professor=nome_professor, disciplina=disciplina, horas=horas,
        slots=slots, intervalos_slots=intervalos_slots, pares_conflito=pares_conflito,
        slots_sem_hora_fim=slots_sem_hora_fim, turnos=turnos, e=e, w=w, h_min=h_min, h_max=h_max,
    )
end

function construir_modelo(d)
    P, T, K, P_L, P_ativos, R, S = d.P, d.T, d.K, d.P_L, d.P_ativos, d.R, d.S
    disciplina, horas, slots, turnos = d.disciplina, d.horas, d.slots, d.turnos
    e, w, h_min, h_max = d.e, d.w, d.h_min, d.h_max

    model = Model(CPLEX.Optimizer)

    @variable(model, x[i in P, j in T], Bin)
    @variable(model, z[i in P, r in R], Bin)
    @variable(model, g[i in P, k in K], Bin)
    @variable(model, s_min >= 0, Int)
    @variable(model, g_max >= 0, Int)

    # (1) Cada turma recebe exatamente um professor.
    @constraint(model, cobertura[j in T], sum(x[i,j] for i in P) == 1)

    # (2) Professor precisa ser qualificado e estar disponivel para a turma.
    @constraint(model, elegibilidade[i in P, j in T], x[i,j] <= e[(i,j)])
    @constraint(model, afastados[i in P_L, j in T], x[i,j] == 0)

    # (3) Carga semanal minima e maxima de professores ativos.
    @constraint(model, carga_min[i in P_ativos], sum(horas[j] * x[i,j] for j in T) >= h_min[i])
    @constraint(model, carga_max[i in P_ativos], sum(horas[j] * x[i,j] for j in T) <= h_max[i])

    # (4) Piso da satisfacao dos professores ativos.
    if isempty(P_ativos)
        @constraint(model, piso_sem_professores_ativos, s_min == 0)
    else
        @constraint(model, piso_satisfacao[i in P_ativos], s_min <= sum(w[(i,j)] * x[i,j] for j in T))
    end

    # (5)-(6) Liga a alocacao binaria a disciplinas distintas lecionadas.
    @constraint(model, liga_disciplina[i in P, j in T], x[i,j] <= g[i, disciplina[j]])
    @constraint(model, liga_disciplina_reversa[i in P, k in K],
        g[i,k] <= sum(x[i,j] for j in T if disciplina[j] == k))

    # (7) Teto do numero de disciplinas distintas por professor.
    @constraint(model, teto_disciplinas[i in P], g_max >= sum(g[i,k] for k in K))

    # (8) Turmas com encontros sobrepostos nao podem ficar com o mesmo professor.
    @constraint(model, conflito_intervalo[i in P, q in eachindex(d.pares_conflito)],
        x[i, d.pares_conflito[q][1]] + x[i, d.pares_conflito[q][2]] <= 1)

    # (9)-(10) Liga as alocacoes aos turnos semanais ocupados.
    @constraint(model, liga_turno[i in P, j in T, r in turnos[j]], x[i,j] <= z[i,r])
    @constraint(model, liga_turno_reversa[i in P, r in R],
        z[i,r] <= sum(x[i,j] for j in T if r in turnos[j]))

    @expression(model, F, sum(w[(i,j)] * x[i,j] for i in P for j in T))
    @expression(model, C, sum(z[i,r] for i in P for r in R))

    @objective(model, Max, ALPHA_F * F + ALPHA_S * s_min - ALPHA_C * C - ALPHA_G * g_max)
    return (model=model, x=x, z=z, g=g, s_min=s_min, g_max=g_max, F=F, C=C)
end

function nome_seguro(texto::AbstractString)
    return replace(String(texto), r"[^A-Za-z0-9_-]" => "_")
end

function valor_numerico_seguro(f)
    v = try
        f()
    catch
        nothing
    end
    if v isa Real && isfinite(v)
        return Float64(v)
    end
    return nothing
end

function tempo_agora()
    return time_ns()
end

function resolver_instancia(caminho::AbstractString; tempo_limite::Float64, gap_alvo::Float64, threads::Int)
    t0 = tempo_agora()
    d = carregar_instancia(caminho)
    tempo_carregamento = (tempo_agora() - t0) / 1e9

    t1 = tempo_agora()
    vars = construir_modelo(d)
    model = vars.model
    set_optimizer_attribute(model, "CPX_PARAM_TILIM", tempo_limite)
    set_optimizer_attribute(model, "CPX_PARAM_EPGAP", gap_alvo)
    set_optimizer_attribute(model, "CPX_PARAM_THREADS", threads)
    tempo_construcao = (tempo_agora() - t1) / 1e9

    mkpath(DIRETORIO_RESULTADOS)
    prefixo = nome_seguro(d.id)
    caminho_lp = joinpath(DIRETORIO_RESULTADOS, prefixo * ".lp")
    t2 = tempo_agora()
    write_to_file(model, caminho_lp)
    tempo_exportacao_lp = (tempo_agora() - t2) / 1e9

    println("\n" * "="^72)
    println("Instancia: ", d.id)
    println("Descricao: ", d.descricao)
    println("Arquivo:   ", abspath(caminho))
    println("Professores: ", length(d.P), " | Turmas: ", length(d.T),
            " | Disciplinas: ", length(d.K), " | Slots distintos: ", length(d.S),
            " | pares de turmas em conflito: ", length(d.pares_conflito))
    if d.slots_sem_hora_fim > 0
        println("Aviso: ", d.slots_sem_hora_fim,
                " slot(s) sem horario_fim. Para esses slots, o conflito usa somente dia e horario inicial.")
    end
    println("Limite de tempo: ", tempo_limite, " s | GAP relativo alvo: ", gap_alvo, " | threads: ", threads)

    t3 = tempo_agora()
    optimize!(model)
    tempo_otimizacao_parede = (tempo_agora() - t3) / 1e9
    tempo_otimizacao_solver = valor_numerico_seguro(() -> solve_time(model))
    status = string(termination_status(model))
    gap_final = valor_numerico_seguro(() -> relative_gap(model))
    bound_final = valor_numerico_seguro(() -> objective_bound(model))

    println("Status: ", status)
    println("Tempo solver (relatado): ", isnothing(tempo_otimizacao_solver) ? "indisponivel" : round(tempo_otimizacao_solver; digits=4), " s")
    println("Tempo otimizar! (parede): ", round(tempo_otimizacao_parede; digits=4), " s")
    println("GAP relativo final: ", isnothing(gap_final) ? "indisponivel" : round(gap_final; digits=6))
    println("Bound objetivo: ", isnothing(bound_final) ? "indisponivel" : round(bound_final; digits=6))

    resultado = Dict{String,Any}(
        "instancia" => d.id,
        "arquivo" => basename(caminho),
        "status" => status,
        "tempo_limite_configurado_s" => tempo_limite,
        "gap_relativo_alvo" => gap_alvo,
        "threads" => threads,
        "tempo_carregamento_s" => tempo_carregamento,
        "tempo_construcao_s" => tempo_construcao,
        "tempo_exportacao_lp_s" => tempo_exportacao_lp,
        "tempo_otimizacao_parede_s" => tempo_otimizacao_parede,
        "tempo_total_s" => tempo_carregamento + tempo_construcao + tempo_exportacao_lp + tempo_otimizacao_parede,
        "tempo_otimizacao_solver_s" => tempo_otimizacao_solver,
        "gap_relativo_final" => gap_final,
        "bound_objetivo" => bound_final,
        "objetivo" => nothing,
        "preferencia_total_F" => nothing,
        "piso_satisfacao" => nothing,
        "turnos_ocupados_C" => nothing,
        "teto_disciplinas_g" => nothing,
        "numero_professores" => length(d.P),
        "numero_turmas" => length(d.T),
        "numero_disciplinas" => length(d.K),
        "numero_slots" => length(d.S),
        "numero_pares_conflito" => length(d.pares_conflito),
        "slots_sem_hora_fim" => d.slots_sem_hora_fim,
        "alocacoes" => Dict{String,String}(),
    )

    if has_values(model)
        resultado["objetivo"] = valor_numerico_seguro(() -> objective_value(model))
        resultado["preferencia_total_F"] = valor_numerico_seguro(() -> value(vars.F))
        resultado["piso_satisfacao"] = valor_numerico_seguro(() -> value(vars.s_min))
        resultado["turnos_ocupados_C"] = valor_numerico_seguro(() -> value(vars.C))
        resultado["teto_disciplinas_g"] = valor_numerico_seguro(() -> value(vars.g_max))

        alocacoes = Dict{String,String}()
        for j in d.T, i in d.P
            if value(vars.x[i,j]) > 0.5
                alocacoes[j] = i
                println("  ", j, " -> ", d.nome_professor[i],
                        " | preferencia = ", d.w[(i,j)],
                        " | carga da turma = ", d.horas[j], " unidade(s)/semana")
            end
        end
        resultado["alocacoes"] = alocacoes

        println("F = ", resultado["preferencia_total_F"],
                " | s_min = ", resultado["piso_satisfacao"],
                " | C = ", resultado["turnos_ocupados_C"],
                " | g_max = ", resultado["teto_disciplinas_g"])
        println("Cargas e satisfacao por professor:")
        for i in d.P
            carga = sum(d.horas[j] * value(vars.x[i,j]) for j in d.T)
            satisfacao = sum(d.w[(i,j)] * value(vars.x[i,j]) for j in d.T)
            println("  ", d.nome_professor[i], ": carga = ", carga,
                    "; satisfacao = ", satisfacao, i in d.P_L ? " (afastado)" : "")
        end
    else
        println("Nenhuma solucao viavel disponivel. Verifique o status do solver e os dados da instancia.")
    end

    caminho_resultado = joinpath(DIRETORIO_RESULTADOS, prefixo * "_resultado.json")
    open(caminho_resultado, "w") do io
        JSON.print(io, resultado, 2)
        println(io)
    end
    println("Modelo LP: ", caminho_lp)
    println("Resumo JSON: ", caminho_resultado)
    return resultado
end

function salvar_resumo_csv(resultados)
    caminho = joinpath(DIRETORIO_RESULTADOS, "resumo_execucoes.csv")
    colunas = [
        "instancia", "arquivo", "status", "tempo_limite_configurado_s", "gap_relativo_alvo", "threads",
        "tempo_carregamento_s", "tempo_construcao_s", "tempo_exportacao_lp_s",
        "tempo_otimizacao_parede_s", "tempo_otimizacao_solver_s", "tempo_total_s", "gap_relativo_final",
        "bound_objetivo", "objetivo", "preferencia_total_F", "piso_satisfacao",
        "turnos_ocupados_C", "teto_disciplinas_g", "numero_professores", "numero_turmas",
        "numero_disciplinas", "numero_slots", "numero_pares_conflito", "slots_sem_hora_fim"
    ]
    open(caminho, "w") do io
        println(io, join(colunas, ","))
        for r in resultados
            valores = [get(r, c, nothing) === nothing ? "" : string(get(r, c, "")) for c in colunas]
            println(io, join(valores, ","))
        end
    end
    println("Resumo consolidado: ", caminho)
end

function interpretar_argumentos(args)
    arquivo = nothing
    tempo_limite = TEMPO_LIMITE_PADRAO_SEGUNDOS
    gap_alvo = GAP_RELATIVO_ALVO_PADRAO
    threads = THREADS_PADRAO
    for arg in args
        if startswith(arg, "--time-limit=")
            tempo_limite = parse(Float64, split(arg, "=", limit=2)[2])
        elseif startswith(arg, "--gap=")
            gap_alvo = parse(Float64, split(arg, "=", limit=2)[2])
        elseif startswith(arg, "--threads=")
            threads = parse(Int, split(arg, "=", limit=2)[2])
        elseif arg == "--help" || arg == "-h"
            println("Uso: julia --project=. PAPT_JuMP.jl <arquivo.json|--all> [--time-limit=3600] [--gap=0.01] [--threads=1]")
            println("Use --gap=0.0 para solicitar prova de otimalidade, respeitando o limite de tempo.")
            return nothing
        elseif startswith(arg, "--")
            error("Argumento desconhecido: $(arg)")
        elseif isnothing(arquivo)
            arquivo = arg
        else
            error("Informe apenas um arquivo JSON ou --all.")
        end
    end
    isnothing(arquivo) && error("Uso: julia --project=. PAPT_JuMP.jl <arquivo.json|--all> [--time-limit=3600] [--gap=0.01] [--threads=1]")
    tempo_limite > 0 || error("--time-limit precisa ser maior que zero.")
    0.0 <= gap_alvo <= 1.0 || error("--gap precisa estar no intervalo [0,1].")
    threads >= 0 || error("--threads deve ser zero (automatico) ou um inteiro positivo.")
    return (arquivo=arquivo, tempo_limite=tempo_limite, gap_alvo=gap_alvo, threads=threads)
end

function main(args)
    opcoes = interpretar_argumentos(args)
    isnothing(opcoes) && return

    if opcoes.arquivo == "--all"
        arquivos = sort(filter(p -> endswith(lowercase(p), ".json"), readdir(DIRETORIO_INSTANCIAS; join=true)))
        isempty(arquivos) && error("Nenhum arquivo .json encontrado em $(DIRETORIO_INSTANCIAS).")
    else
        informado = opcoes.arquivo
        candidato = isfile(informado) ? informado : joinpath(DIRETORIO_INSTANCIAS, informado)
        isfile(candidato) || error("Arquivo nao encontrado: $(informado). Informe um caminho ou nome dentro de instancias/.")
        arquivos = [candidato]
    end

    resultados = Dict{String,Any}[]
    for arquivo in arquivos
        push!(resultados, resolver_instancia(arquivo; tempo_limite=opcoes.tempo_limite, gap_alvo=opcoes.gap_alvo, threads=opcoes.threads))
    end
    salvar_resumo_csv(resultados)
end

if abspath(PROGRAM_FILE) == abspath(@__FILE__)
    main(ARGS)
end
