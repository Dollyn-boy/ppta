# Instancias do PAPT em Julia/JuMP/CPLEX

## Arquivo canônico de referência

Use `instancias/referencia_v001.json`. É a instância de 3 professores e 4 turmas fornecida para validar a formulação. A versão JSON original, com inconsistências de turnos e código de disciplina, foi preservada fora da pasta de execução em `../../referencias/instancia_de_referencia_recebida.json`.

A expectativa para o objetivo ponderado atual é `F=17`, `s_min=3`, `C=8`, `g_max=1`, `Z=9,9`. Esses valores vêm de enumeração independente de todas as 81 atribuições e devem ser conferidos na execução com o solver.

## Estrutura JSON

- `professores`: `id`, `nome`, `carga_min`, `carga_max`, `afastado`.
- `turmas`: `id`, `disciplina`, `horas`, `slots`.
- Slot mínimo: `dia`, `horario` (HH:MM) e `turno` (`Dia-mat`, `Dia-vesp` ou `Dia-not`). `horario_fim` é opcional e permite modelar conflitos por sobreposição de intervalo.
- `turnos_semanais`: conjunto sem duplicatas igual à união dos turnos utilizados.
- `pares_professor_turma`: um registro por par, com `professor`, `turma`, `qualificado`, `disponivel` e `preferencia` inteira de 0 a 5.

A elegibilidade é `qualificado && disponivel`. Preferências de pares inelegíveis são carregadas como zero.

## Instanciar o ambiente

Execute na pasta `model_ic`:

```powershell
julia --project=. -e 'using Pkg; Pkg.instantiate()'
```

O `Project.toml` inclui `JuMP`, `CPLEX` e `JSON`, e o `Manifest.toml` do projeto-base foi preservado. A instalação/licença do CPLEX deve estar configurada no computador.

## Execução

```powershell
julia --project=. PAPT_JuMP.jl referencia_v001.json --time-limit=3600 --gap=0.0 --threads=1
julia --project=. PAPT_JuMP.jl sintetica_pequena.json --time-limit=300 --gap=0.01 --threads=1
julia --project=. PAPT_JuMP.jl --all --time-limit=600 --gap=0.01 --threads=1
```

`--time-limit` é o limite de tempo de cada otimização em segundos. `--gap` é a tolerância relativa para parada do CPLEX; `0.01` representa 1% e `0.0` solicita busca de prova de otimalidade dentro do limite configurado. `--threads=1` fixa uma thread, enquanto `--threads=0` deixa a escolha ao CPLEX.

## Resultados produzidos

Em `resultados/` o programa grava um LP, um JSON com métricas por instância e `resumo_execucoes.csv`. Os campos de tempo são separados para leitura JSON, construção do modelo, exportação LP, tempo de parede de `optimize!` e tempo reportado pelo solver, tempo total das fases medidas e número de threads. Quando o solver fornece os atributos, também são gravados `objective_bound` e `relative_gap`.

## Interpretação do modelo atual

A função objetivo permanece ponderada: `Z = 0.60 F + 0.20 s_min - 0.10 C - 0.10 g_max`. Ela não é equivalente à formulação lexicográfica documentada em algumas versões do PDF/LaTeX.

Se os slots contiverem `horario_fim`, conflitos são calculados pela sobreposição dos intervalos no mesmo dia. Se um slot não tiver hora final, a compatibilidade é feita por igualdade de `(dia, horario)`; portanto, prefira horários completos para a extração real.

`--all` busca somente arquivos `.json` diretamente nesta pasta, não percorre subpastas, evitando que instâncias históricas sejam incluídas na bateria padrão.
