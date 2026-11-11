"""Gera static/index.html com a agenda embutida a partir do JSON de resultado e dos CSVs."""
import json, pandas as pd, sys
from pathlib import Path

base = Path(__file__).parent
resultado = json.load(open(base/"dados/uefs_engenharia_computacao_2026_2_v002_resultado.json", encoding="utf-8"))
instancia = json.load(open(base/"dados/oferta2026_2.json", encoding="utf-8"))
oferta = pd.read_csv(base/"dados/oferta_turmas.csv", encoding="utf-8-sig") 
disc = pd.read_csv(base/"dados/disciplinas_para_forms_uefs_2026_2.csv", encoding="utf-8-sig")
aloc = resultado["alocacoes"]

# monta dicionários de nome_prof de professores e disciplinas
nome_prof = {}
for professor in instancia["professores"]:
    nome_prof[professor["id"]] = professor["nome"]
nome_disc = dict(zip(disc.codigo_disciplina, disc.nome_disciplina))


DIAS = ["Seg", "Ter", "Qua", "Qui", "Sex", "Sab"]
mins = lambda s: int(s[:2]) * 60 + int(s[3:])
fmt = lambda m: f"{m//60:02d}:{m%60:02d}"

professores = {p: {"nome": nome_prof[p], "blocos": [], "sem_horario": []} for p in sorted(set(aloc.values()))}

# junta slots de 30 min consecutivos da mesma turma/dia em um único bloco
for (turma, dia), g in oferta.groupby(["id_turma", "dia"], sort=False):
    g = g.assign(a=g.horario_inicio.map(mins), b=g.horario_fim.map(mins)).sort_values("a")
    cod, local = g.codigo_disciplina.iloc[0], g.local.dropna().iloc[0] if g.local.notna().any() else ""
    cur = None
    for a, b in zip(g.a, g.b):
        if cur and cur[1] == a: cur[1] = b
        else:
            cur = [a, b]
            professores[aloc[turma]]["blocos"].append([turma, cod, nome_disc[cod], DIAS.index(dia), cur, local])
for p in professores.values():                      # fecha o fim de cada bloco (lista mutável)
    p["blocos"] = [[t, c, n, d, fmt(r[0]), fmt(r[1]), l] for t, c, n, d, r, l in sorted(p["blocos"], key=lambda x: (x[3], x[4][0]))]

# turmas alocadas que não existem no CSV de horários
com_horario = set(oferta.id_turma)
for turma, p in aloc.items():
    if turma not in com_horario:
        cod = turma.split("-")[0]
        professores[p]["sem_horario"].append([turma, nome_disc.get(cod, cod)])

dados = {"professores": professores}
html = (base/"template.html").read_text(encoding="utf-8").replace("/*DADOS*/null", json.dumps(dados, ensure_ascii=False, separators=(",", ":")))
out = base/"static/index.html"; out.write_text(html, encoding="utf-8")
nb = sum(len(p["blocos"]) for p in professores.values())
print(f"{len(professores)} professores, {nb} blocos, {len(html)/1024:.1f} KB -> {out}")
