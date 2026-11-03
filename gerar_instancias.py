#!/usr/bin/env python3

"""Gera instancias sinteticas de teste para o PAPT em formato JSON.\n\nCada encontro semanal e expandido em slots atomicos de 30 minutos. A atribuicao-testemunha verifica a intersecao desses slots, incluindo sobreposicoes parciais.

Atribuicoes-testemunha sao construidas antes dos pares de elegibilidade:

para cada turma, o professor-testemunha e explicitamente qualificado e

esta disponivel, e os horarios das turmas desse professor nao se sobrepoem.

Capacidade (carga semanal) dos professores:

  --modo-carga fixa      -> todos os professores recebem [carga-minima, carga-maxima].

  --modo-carga aleatoria -> cada professor recebe limites sorteados dentro de

                            [carga-minima, carga-maxima], sempre contendo a carga

                            da atribuicao-testemunha.

Em ambos os modos a carga-testemunha precisa caber na faixa global; caso

contrario o gerador aborta, garantindo que a instancia tenha ao menos uma

solucao viavel, salvo alteracoes manuais.

"""

from __future__ import annotations

import argparse

import json

import random

from pathlib import Path

DIAS = ["Seg", "Ter", "Qua", "Qui", "Sex"]

MODOS_CARGA = ("aleatoria", "fixa")

EPS = 1e-9  # tolerancia para erros de ponto flutuante nas somas de horas

GRANULARIDADE_MINUTOS = 30

def hora_para_minutos(horario: str) -> int:
    hora, minuto = map(int, horario.split(":"))
    if not (0 <= hora <= 23 and 0 <= minuto <= 59):
        raise ValueError(f"Horario invalido: {horario}")
    return hora * 60 + minuto

def minutos_para_hora(minutos: int) -> str:
    return f"{minutos // 60:02d}:{minutos % 60:02d}"

def expandir_encontro(
    dia: str,
    inicio: str,
    duracao_minutos: int,
    turno: str,
) -> list[dict]:
    """Expande um encontro original em slots atomicos de 30 minutos."""
    inicio_min = hora_para_minutos(inicio)

    if duracao_minutos <= 0 or duracao_minutos % GRANULARIDADE_MINUTOS != 0:
        raise ValueError(
            "A duracao de cada encontro deve ser multipla de 30 minutos."
        )

    fim_min = inicio_min + duracao_minutos
    if fim_min > 24 * 60:
        raise ValueError("O encontro ultrapassa o limite do dia.")

    if inicio_min % GRANULARIDADE_MINUTOS != 0:
        raise ValueError(
            f"O inicio {inicio} nao esta alinhado a 30 minutos."
        )

    return [
        {
            "dia": dia,
            "horario": minutos_para_hora(minuto),
            "horario_fim": minutos_para_hora(minuto + GRANULARIDADE_MINUTOS),
            "turno": turno,
        }
        for minuto in range(inicio_min, fim_min, GRANULARIDADE_MINUTOS)
    ]

def perfil_preferencia(rng: random.Random, perfil: str) -> int:

    if perfil == "uniforme":

        return rng.randint(0, 5)

    if perfil == "alta":

        return rng.randint(3, 5)

    if perfil == "baixa":

        return rng.randint(0, 2)

    if perfil == "polarizada":

        return rng.choice([0, 5])

    if perfil == "moderada":

        return rng.randint(2, 4)

    raise ValueError(f"Perfil de preferencia desconhecido: {perfil}")

def validar_capacidade(args: argparse.Namespace, n_turmas: int) -> None:

    """Valida a especificacao de capacidade antes de qualquer sorteio."""

    if args.modo_carga not in MODOS_CARGA:

        raise ValueError(f"Modo de carga desconhecido: {args.modo_carga}")

    if args.carga_minima < 0:

        raise ValueError("A carga minima nao pode ser negativa.")

    if args.carga_maxima < args.carga_minima:

        raise ValueError("A carga maxima deve ser maior ou igual a minima.")  # A distribuicao round-robin da testemunha da a cada professor  # floor(n/P) ou ceil(n/P) turmas; checa os extremos logo no inicio.
    base, resto = divmod(n_turmas, args.professores)

    menor_carga = base * args.horas_por_turma

    maior_carga = (base + (1 if resto else 0)) * args.horas_por_turma

    if menor_carga < args.carga_minima - EPS:

        raise ValueError(

            f"Com {n_turmas} turmas e {args.professores} professores, alguns professores "

            f"teriam {menor_carga:g} h, abaixo da carga minima de {args.carga_minima:g} h. "

            "Aumente turmas/horas por turma ou reduza a carga minima."

        )

    if maior_carga > args.carga_maxima + EPS:

        raise ValueError(

            f"Com {n_turmas} turmas e {args.professores} professores, alguns professores "

            f"teriam {maior_carga:g} h, acima da carga maxima de {args.carga_maxima:g} h. "

            "Reduza turmas/horas por turma ou aumente a carga maxima."

        )

def gerar(args: argparse.Namespace) -> dict:

    rng = random.Random(args.semente)

    if args.professores < 1 or args.disciplinas < 1 or args.turmas_por_disciplina < 1:

        raise ValueError("Professores, disciplinas e turmas por disciplina devem ser positivos.")

    if args.slots_por_turma < 1 or args.slots_por_turma > len(DIAS):

        raise ValueError("slots_por_turma deve estar entre 1 e 5 para usar dias distintos.")

    n_turmas = args.disciplinas * args.turmas_por_disciplina

    if n_turmas < args.professores:

        raise ValueError(

            "Para garantir carga positiva de todos os professores, gere pelo menos tantas turmas quanto professores."

        )

    validar_capacidade(args, n_turmas)

    horarios_por_conflito = {

        "baixo": ["07:30", "09:30", "13:30", "15:30", "17:30"],

        "medio": ["09:30", "11:30", "13:30", "15:30"],

        "alto": ["09:30", "15:30", "17:30"],

    }

    horarios = horarios_por_conflito[args.conflitos]

    duracao_calculada = args.horas_por_turma * 60 / args.slots_por_turma
    duracao_encontro = round(duracao_calculada)

    if abs(duracao_calculada - duracao_encontro) > EPS:
        raise ValueError(
            "A duracao calculada de cada encontro nao resulta em minutos inteiros."
        )
    if duracao_encontro % GRANULARIDADE_MINUTOS != 0:
        raise ValueError(
            "A duracao de cada encontro precisa ser multipla de 30 minutos. "
            "Ajuste --horas-por-turma ou --slots-por-turma."
        )

    universo_encontros = []
    for dia in DIAS:
        for horario in horarios:
            turno_dia = "mat" if horario < "12:00" else "vesp"
            universo_encontros.append({
                "dia": dia,
                "horario": horario,
                "turno": f"{dia}-{turno_dia}",
            })

    # A atribuicao-testemunha e round-robin; isso distribui turmas entre todos.
    professores = []

    ids_professores = []

    for i in range(1, args.professores + 1):

        pid = f"P{i:02d}"

        ids_professores.append(pid)

        professores.append({

            "id": pid,

            "nome": f"Professor {i:02d}",

            "carga_min": 0,

            "carga_max": 0,

            "afastado": False,

        })

    disciplinas = [f"DISC{i:02d}" for i in range(1, args.disciplinas + 1)]

    turmas = []

    professor_testemunha = {}

    slots_ocupados_por_professor = {pid: set() for pid in ids_professores}

    carga_testemunha = {pid: 0.0 for pid in ids_professores}

    for indice in range(n_turmas):

        disciplina = disciplinas[indice // args.turmas_por_disciplina]

        turma_num = indice % args.turmas_por_disciplina + 1

        tid = f"{disciplina}-T{turma_num:02d}"

        pid = ids_professores[indice % args.professores]

        ocupados = slots_ocupados_por_professor[pid]

        escolhidos = None

        for _ in range(20000):

            candidatos = rng.sample(universo_encontros, args.slots_por_turma)
            dias_candidatos = [s["dia"] for s in candidatos]
            if len(set(dias_candidatos)) != args.slots_por_turma:
                continue

            slots_candidatos = []
            for encontro in candidatos:
                slots_candidatos.extend(
                    expandir_encontro(
                        dia=encontro["dia"],
                        inicio=encontro["horario"],
                        duracao_minutos=duracao_encontro,
                        turno=encontro["turno"],
                    )
                )

            chaves = {
                (s["dia"], s["horario"])
                for s in slots_candidatos
            }
            if chaves & ocupados:
                continue

            escolhidos = slots_candidatos
            break

        if escolhidos is None:

            raise ValueError(

                f"Nao foi possivel distribuir horarios para {tid}. Reduza turmas/professor, "

                "aumente o conjunto de horarios ou use conflitos='baixo'."

            )

        for s in escolhidos:

            ocupados.add((s["dia"], s["horario"]))

        professor_testemunha[tid] = pid

        carga_testemunha[pid] += args.horas_por_turma

        turmas.append({

            "id": tid,

            "disciplina": disciplina,

            "horas": args.horas_por_turma,

            "slots": sorted(escolhidos, key=lambda s: (DIAS.index(s["dia"]), s["horario"])),

        })  # Define os limites de carga semanal de cada professor.  # Invariante: carga_min <= carga-testemunha <= carga_max e ambos dentro de  # [carga-minima, carga-maxima].
    carga_minima = args.carga_minima

    carga_maxima = args.carga_maxima

    for p in professores:

        carga = round(carga_testemunha[p["id"]], 6)  # Garantia (reforco da validacao previa): a testemunha cabe na faixa global.
        if carga < carga_minima - EPS or carga > carga_maxima + EPS:

            raise ValueError(

                f"{p['id']} recebeu {carga:g} h na atribuicao-testemunha, "

                f"fora da faixa de {carga_minima:g} a {carga_maxima:g} h. "

                "Ajuste o numero de turmas, as horas por turma ou os limites."

            )

        if args.modo_carga == "aleatoria":  # Sorteia limites individuais; o arredondamento nunca pode  # excluir a testemunha nem sair da faixa global.
            minimo = round(rng.uniform(carga_minima, carga), 2)

            maximo = round(rng.uniform(carga, carga_maxima), 2)

            minimo = min(max(minimo, carga_minima), carga)

            maximo = max(min(maximo, carga_maxima), carga)

        else:  # modo fixa
            minimo = carga_minima

            maximo = carga_maxima

        p["carga_min"] = minimo

        p["carga_max"] = maximo

    pares = []

    for p in professores:

        pid = p["id"]

        for turma in turmas:

            tid = turma["id"]

            testemunha = professor_testemunha[tid] == pid

            qualificado = testemunha or (rng.random() < args.densidade_qualificacao)

            disponivel = testemunha or (rng.random() < args.disponibilidade)

            pref = perfil_preferencia(rng, args.perfil_preferencia)

            pares.append({

                "professor": pid,

                "turma": tid,

                "qualificado": qualificado,

                "disponivel": disponivel,

                "preferencia": pref if (qualificado and disponivel) else 0,

            })

    turnos = [f"{dia}-{parte}" for dia in DIAS for parte in ("mat", "vesp")]

    return {

        "id": args.nome,

        "descricao": "Instancia sintetica gerada para testes controlados do PAPT.",

        "criterios_geracao": {

            "semente": args.semente,

            "professores": args.professores,

            "disciplinas": args.disciplinas,

            "turmas_por_disciplina": args.turmas_por_disciplina,

            "horas_por_turma": args.horas_por_turma,

            "slots_por_turma": args.slots_por_turma,
            "significado_slots_por_turma": "quantidade de encontros semanais originais",
            "duracao_encontro_minutos": duracao_encontro,
            "granularidade_minutos": GRANULARIDADE_MINUTOS,
            "representacao_horarios": "slots_atomicos",
            "convencao_intervalos": "[inicio, fim)",

            "densidade_qualificacao": args.densidade_qualificacao,

            "disponibilidade": args.disponibilidade,

            "perfil_preferencia": args.perfil_preferencia,

            "modo_carga": args.modo_carga,

            "carga_minima": args.carga_minima,

            "carga_maxima": args.carga_maxima,

            "conflitos": args.conflitos,

        },

        "turnos_semanais": turnos,

        "professores": professores,

        "turmas": turmas,

        "pares_professor_turma": pares,

    }

def main() -> None:

    parser = argparse.ArgumentParser(description=__doc__,

                                     formatter_class=argparse.RawDescriptionHelpFormatter)

    parser.add_argument("--saida", default="instancias", help="Pasta em que o JSON sera salvo.")

    parser.add_argument("--nome", default="sintetica", help="ID/nome base do arquivo.")

    parser.add_argument("--professores", type=int, default=6)

    parser.add_argument("--disciplinas", type=int, default=4)

    parser.add_argument("--turmas-por-disciplina", type=int, default=3)

    parser.add_argument("--horas-por-turma", type=float, default=4.0)

    parser.add_argument(
        "--slots-por-turma",
        type=int,
        default=2,
        help="Quantidade de encontros semanais originais por turma (nao de blocos atomicos).",
    )

    parser.add_argument("--densidade-qualificacao", type=float, default=0.60,

                        help="Probabilidade de qualificacao para pares nao usados pela testemunha (0 a 1).")

    parser.add_argument("--disponibilidade", type=float, default=0.80,

                        help="Probabilidade de disponibilidade para pares nao usados pela testemunha (0 a 1).")

    parser.add_argument("--perfil-preferencia",

                        choices=["uniforme", "alta", "baixa", "polarizada", "moderada"],

                        default="uniforme")

    parser.add_argument(

        "--modo-carga",

        choices=list(MODOS_CARGA),

        default="aleatoria",

        help="Aleatoria: sorteia limites por professor; fixa: usa os mesmos limites para todos.",

    )

    parser.add_argument("--carga-minima", type=float, default=6.0,

                        help="Carga semanal minima em horas (padrao: 6).")

    parser.add_argument("--carga-maxima", type=float, default=12.0,

                        help="Carga semanal maxima em horas (padrao: 12).")

    parser.add_argument("--conflitos", choices=["baixo", "medio", "alto"], default="medio",

                        help="Controla o universo de horarios: menor universo tende a elevar sobreposicoes.")

    parser.add_argument("--semente", type=int, default=42)

    args = parser.parse_args()

    if not 0 <= args.densidade_qualificacao <= 1:

        parser.error("--densidade-qualificacao deve estar entre 0 e 1.")

    if not 0 <= args.disponibilidade <= 1:

        parser.error("--disponibilidade deve estar entre 0 e 1.")

    if args.horas_por_turma <= 0:

        parser.error("--horas-por-turma deve ser positiva.")

    if args.carga_minima < 0:

        parser.error("--carga-minima nao pode ser negativa.")

    if args.carga_maxima < args.carga_minima:

        parser.error("--carga-maxima deve ser maior ou igual a --carga-minima.")

    try:

        dados = gerar(args)

    except ValueError as erro:

        parser.error(str(erro))

    pasta = Path(args.saida)

    pasta.mkdir(parents=True, exist_ok=True)

    destino = pasta / f"{args.nome}.json"

    with destino.open("w", encoding="utf-8") as arquivo:

        json.dump(dados, arquivo, ensure_ascii=False, indent=2)

        arquivo.write("\n")

    print(f"Instancia criada: {destino.resolve()}")

    print(f"Professores: {len(dados['professores'])}")

    print(f"Turmas: {len(dados['turmas'])}")

    print(f"Disciplinas: {len({t['disciplina'] for t in dados['turmas']})}")

    print(f"Pares professor-turma: {len(dados['pares_professor_turma'])}")

    print(f"Modo de carga: {args.modo_carga} (faixa global {args.carga_minima:g}-{args.carga_maxima:g} h)")

    print("A instancia contem uma atribuicao-testemunha viavel antes de modificacoes manuais.")

if __name__ == "__main__":

    main()
