#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Converte dois CSVs em uma instância JSON compatível com o carregador
carregar_instancia() do PAPT_JuMP.jl original.

Entradas:
  1) CSV do Google Forms/Sheets: professores, preferências, indisponibilidades
     e limites individuais de carga horária.
  2) oferta_turmas.csv: disciplinas, turmas, carga semanal e slots de 30 min.

IMPORTANTE:
- Os dados de professores são obtidos EXCLUSIVAMENTE do CSV do Forms.
- Colunas antigas de professor na oferta_turmas.csv, caso existam, são ignoradas.
- A preferência é identificada pelo código no rótulo entre colchetes:
  "... [EXA801 - ALGORITMOS E PROGRAMAÇÃO I]".
- Por padrão, todas as disciplinas presentes na oferta devem ter uma coluna
  de preferência no Forms. O script não assume preferência zero para colunas
  ausentes, pois isso equivaleria a declarar o professor não qualificado.
- Se o Forms responder "Não" à pergunta sobre limites individuais, são usados
  os padrões configuráveis (mínimo 0 h e máximo 12 h por semana).

Uso:
  python converter_forms_ppta.py \
      --csv respostas_formulario_ppta.csv \
      --oferta oferta_turmas.csv \
      --saida instancia_real.json

Opcional:
  --carga-min-padrao 0
  --carga-max-padrao 12
  --id-instancia papt_uefs_2026_2_real
  --descricao "Instância construída a partir do Forms e da oferta UEFS 2026.2"
"""

from __future__ import annotations

import argparse
import csv
import json
import math
import re
import sys
import unicodedata
from collections import OrderedDict
from pathlib import Path
from typing import Any, Dict, Iterable, List, Optional, Sequence, Tuple


# ---------------------------------------------------------------------------
# Configurações e padrões
# ---------------------------------------------------------------------------

CARGA_MIN_PADRAO = 0.0
CARGA_MAX_PADRAO = 12.0

DIAS_CANONICOS = {
    "seg": "Seg",
    "ter": "Ter",
    "qua": "Qua",
    "qui": "Qui",
    "sex": "Sex",
    "sab": "Sab",
    "dom": "Dom",
}

ALIASES_DIAS = {
    "seg": "seg", "segunda": "seg", "segunda feira": "seg",
    "ter": "ter", "terca": "ter", "terca feira": "ter",
    "qua": "qua", "quarta": "qua", "quarta feira": "qua",
    "qui": "qui", "quinta": "qui", "quinta feira": "qui",
    "sex": "sex", "sexta": "sex", "sexta feira": "sex",
    "sab": "sab", "sabado": "sab",
    "dom": "dom", "domingo": "dom",
}

REGEX_FAIXA = re.compile(
    r"(?P<h1>\d{1,2})(?::(?P<m1>\d{2}))?\s*h?\s*"
    r"(?:-|–|—|a|às|ate)\s*"
    r"(?P<h2>\d{1,2})(?::(?P<m2>\d{2}))?\s*h?",
    re.IGNORECASE,
)

REGEX_CODIGO_DISCIPLINA = re.compile(
    r"^\s*([A-Z]{2,}\d{2,})\s*(?:[-–—]|$)",
    re.IGNORECASE,
)

DIAS_ESPERADOS_FORMS = {"seg", "ter", "qua", "qui", "sex", "sab"}


class ErroConversao(Exception):
    """Erro de validação com mensagem destinada ao usuário."""


def normalizar(texto: Any) -> str:
    """Remove acentos, caixa e pontuação; colapsa espaços."""
    s = unicodedata.normalize("NFKD", str(texto or ""))
    s = "".join(ch for ch in s if not unicodedata.combining(ch))
    s = s.casefold()
    s = re.sub(r"[^a-z0-9]+", " ", s)
    return " ".join(s.split())


def vazio(valor: Any) -> bool:
    if valor is None:
        return True
    texto = str(valor).strip()
    return texto == "" or texto.casefold() in {"nan", "none", "null"}


def normalizar_dia(dia: str) -> str:
    chave = normalizar(dia)
    if chave not in ALIASES_DIAS:
        raise ErroConversao(f"Dia da semana não reconhecido: '{dia}'.")
    return ALIASES_DIAS[chave]


def dia_canonico(dia: str) -> str:
    return DIAS_CANONICOS[normalizar_dia(dia)]


def para_minutos(hora: str, contexto: str = "") -> int:
    texto = str(hora).strip()
    m = re.fullmatch(r"(\d{1,2}):(\d{2})", texto)
    if not m:
        raise ErroConversao(
            f"Horário inválido '{hora}'{f' em {contexto}' if contexto else ''}. "
            "Formato esperado: HH:MM."
        )
    h, minuto = int(m.group(1)), int(m.group(2))
    if not (0 <= h <= 23 and 0 <= minuto <= 59):
        raise ErroConversao(f"Horário fora do intervalo válido: '{hora}'.")
    return h * 60 + minuto


def formatar_hora(minutos: int) -> str:
    return f"{minutos // 60:02d}:{minutos % 60:02d}"


def ler_csv(
    caminho: Path,
    delimitador: Optional[str] = None,
) -> Tuple[List[str], List[Dict[str, str]]]:
    """Lê CSV UTF-8/UTF-8-BOM e remove espaços em cabeçalhos e valores."""
    if not caminho.is_file():
        raise ErroConversao(f"Arquivo CSV não encontrado: {caminho}")

    with caminho.open("r", encoding="utf-8-sig", newline="") as arquivo:
        amostra = arquivo.read(16384)
        arquivo.seek(0)

        if delimitador:
            separador = delimitador
        else:
            try:
                separador = csv.Sniffer().sniff(amostra, delimiters=",;\t").delimiter
            except csv.Error:
                separador = ","

        leitor = csv.DictReader(arquivo, delimiter=separador)
        if not leitor.fieldnames:
            raise ErroConversao(f"O CSV não possui cabeçalho: {caminho}")

        cabecalhos_originais = [str(h or "").strip() for h in leitor.fieldnames]
        if len(cabecalhos_originais) != len(set(cabecalhos_originais)):
            duplicados = sorted({
                h for h in cabecalhos_originais
                if cabecalhos_originais.count(h) > 1
            })
            raise ErroConversao(
                f"Existem cabeçalhos duplicados em {caminho.name}: {duplicados}"
            )

        linhas: List[Dict[str, str]] = []
        for numero, linha in enumerate(leitor, start=2):
            if not linha or not any(not vazio(v) for v in linha.values()):
                continue
            registro = {
                str(k).strip(): ("" if vazio(v) else str(v).strip())
                for k, v in linha.items()
                if k is not None
            }
            registro["__linha_csv__"] = str(numero)
            linhas.append(registro)

    if not linhas:
        raise ErroConversao(f"O CSV não contém registros: {caminho}")
    return cabecalhos_originais, linhas


def achar_coluna_por_teste(
    cabecalhos: Sequence[str],
    teste,
    descricao: str,
    obrigatoria: bool = True,
) -> Optional[str]:
    candidatos = [h for h in cabecalhos if teste(normalizar(h))]
    if len(candidatos) == 1:
        return candidatos[0]
    if len(candidatos) > 1:
        raise ErroConversao(
            f"Mais de uma coluna corresponde a '{descricao}': {candidatos}. "
            "Torne o título da pergunta mais específico."
        )
    if obrigatoria:
        raise ErroConversao(
            f"Coluna obrigatória não encontrada: '{descricao}'. "
            f"Cabeçalhos disponíveis: {list(cabecalhos)}"
        )
    return None


def descobrir_colunas_principais(
    cabecalhos: Sequence[str],
) -> Dict[str, Optional[str]]:
    nome = achar_coluna_por_teste(
        cabecalhos,
        lambda h: "nome completo" in h or h == "nome",
        "Nome Completo",
    )
    email = achar_coluna_por_teste(
        cabecalhos,
        lambda h: "email" in h and ("institucional" in h or h == "email"),
        "Email Institucional",
    )
    pergunta_limites = achar_coluna_por_teste(
        cabecalhos,
        lambda h: "limites individuais" in h and "carga horaria" in h,
        "Possui limites individuais de carga horária?",
    )
    carga_min = achar_coluna_por_teste(
        cabecalhos,
        lambda h: ("quantidade minima" in h or "carga horaria semanal minima" in h)
                  and "hora" in h,
        "carga horária mínima",
    )
    carga_max = achar_coluna_por_teste(
        cabecalhos,
        lambda h: ("quantidade maxima" in h or "carga horaria semanal maxima" in h)
                  and "hora" in h,
        "carga horária máxima",
    )
    return {
        "nome": nome,
        "email": email,
        "limites": pergunta_limites,
        "carga_min": carga_min,
        "carga_max": carga_max,
    }


def extrair_rotulo_colchetes(cabecalho: str) -> Optional[str]:
    m = re.search(r"\[([^\]]+)\]\s*$", cabecalho)
    return m.group(1).strip() if m else None


def extrair_codigo_disciplina(rotulo: str) -> str:
    m = REGEX_CODIGO_DISCIPLINA.match(rotulo)
    if not m:
        raise ErroConversao(
            f"Não consegui extrair o código da disciplina do rótulo '{rotulo}'. "
            "Use títulos no formato '[EXA801 - NOME DA DISCIPLINA]'."
        )
    return m.group(1).upper()


def descobrir_colunas_grade(
    cabecalhos: Sequence[str],
) -> Tuple[Dict[str, str], Dict[str, str]]:
    """
    Retorna:
      preferencias: {codigo_disciplina: nome_coluna_csv}
      indisponibilidades: {dia_normalizado: nome_coluna_csv}
    """
    preferencias: Dict[str, str] = {}
    indisponibilidades: Dict[str, str] = {}

    for cabecalho in cabecalhos:
        rotulo = extrair_rotulo_colchetes(cabecalho)
        if not rotulo:
            continue

        prefixo = normalizar(cabecalho[:cabecalho.rfind("[")])

        if "preferencia" in prefixo:
            codigo = extrair_codigo_disciplina(rotulo)
            if codigo in preferencias:
                raise ErroConversao(
                    f"Há mais de uma coluna de preferência para o código {codigo}."
                )
            preferencias[codigo] = cabecalho

        elif "disponivel" in prefixo or "indisponibilidade" in prefixo:
            dia = normalizar_dia(rotulo)
            if dia in indisponibilidades:
                raise ErroConversao(
                    f"Há mais de uma coluna de indisponibilidade para o dia {rotulo}."
                )
            indisponibilidades[dia] = cabecalho

    if not preferencias:
        raise ErroConversao(
            "Não foram encontradas colunas da grade de preferência. "
            "Os títulos devem conter o código no colchete, por exemplo "
            "'Preferência [EXA801 - ALGORITMOS E PROGRAMAÇÃO I]'."
        )

    if not indisponibilidades:
        raise ErroConversao(
            "Não foram encontradas colunas da grade de indisponibilidade."
        )

    dias_ausentes = DIAS_ESPERADOS_FORMS - set(indisponibilidades)
    if dias_ausentes:
        nomes = [DIAS_CANONICOS[d] for d in sorted(dias_ausentes)]
        raise ErroConversao(
            f"Faltam colunas de indisponibilidade no Forms para: {nomes}."
        )

    return preferencias, indisponibilidades


def parse_preferencia(valor: Any, contexto: str) -> int:
    texto = str(valor or "").strip()
    m = re.fullmatch(r"\s*([0-5])(?:\s*[-—–].*)?\s*", texto)
    if not m:
        raise ErroConversao(
            f"Preferência inválida ou vazia em {contexto}: '{valor}'. "
            "Esperava um número inteiro de 0 a 5."
        )
    return int(m.group(1))


def parse_numero(valor: Any, contexto: str) -> float:
    texto = str(valor or "").strip().lower()
    texto = texto.replace("horas", "").replace("hora", "").replace("h", "").strip()
    if "," in texto and "." not in texto:
        texto = texto.replace(",", ".")
    try:
        numero = float(texto)
    except ValueError as exc:
        raise ErroConversao(
            f"Valor numérico inválido em {contexto}: '{valor}'."
        ) from exc
    if not math.isfinite(numero) or numero < 0:
        raise ErroConversao(f"Valor inválido em {contexto}: '{valor}'.")
    return numero


def resposta_sim(valor: Any, contexto: str) -> bool:
    texto = normalizar(valor)
    if texto.startswith("sim") or texto in {"s", "yes", "y"}:
        return True
    if texto.startswith("nao") or texto in {"n", "no"}:
        return False
    raise ErroConversao(
        f"Resposta não reconhecida em {contexto}: '{valor}'. "
        "Use uma resposta equivalente a Sim ou Não."
    )


def parse_faixas_indisponiveis(
    valor: Any,
    contexto: str,
) -> List[Tuple[int, int]]:
    """Lê uma célula com uma ou mais faixas, ex.: 07:30–09:30, 09:30–11:30."""
    if vazio(valor):
        return []

    texto = str(valor).strip()
    intervalos: List[Tuple[int, int]] = []
    correspondencias = list(REGEX_FAIXA.finditer(texto))
    if not correspondencias:
        raise ErroConversao(
            f"Não consegui interpretar a indisponibilidade em {contexto}: '{valor}'."
        )

    # Garante que não exista texto não interpretado entre as faixas.
    resto = REGEX_FAIXA.sub("", texto)
    resto = re.sub(r"[\s,;]+", "", resto)
    if resto:
        raise ErroConversao(
            f"Há conteúdo não reconhecido na indisponibilidade de {contexto}: "
            f"'{resto}' (célula original: '{valor}')."
        )

    for m in correspondencias:
        h1, m1 = int(m.group("h1")), int(m.group("m1") or 0)
        h2, m2 = int(m.group("h2")), int(m.group("m2") or 0)

        if h1 > 23 or h2 > 24 or m1 > 59 or m2 > 59:
            raise ErroConversao(
                f"Faixa fora do intervalo válido em {contexto}: '{m.group(0)}'."
            )

        inicio = h1 * 60 + m1
        fim = h2 * 60 + m2
        if fim <= inicio:
            raise ErroConversao(
                f"Faixa inválida em {contexto}: '{m.group(0)}'."
            )
        intervalos.append((inicio, fim))

    return intervalos


# ---------------------------------------------------------------------------
# Leitura e validação da oferta institucional (CSV de turmas/slots)
# ---------------------------------------------------------------------------

COLUNAS_OBRIGATORIAS_OFERTA = {
    "id_turma",
    "codigo_disciplina",
    "nome_disciplina",
    "horas_semanais",
    "dia",
    "horario_inicio",
    "horario_fim",
    "turno",
}


def carregar_oferta_csv(
    caminho_oferta: Path,
    delimitador: Optional[str] = None,
) -> Tuple[List[Dict[str, Any]], List[str]]:
    cabecalhos, linhas = ler_csv(caminho_oferta, delimitador)
    cabecalhos_norm = {normalizar(c): c for c in cabecalhos}

    faltantes = [
        campo for campo in COLUNAS_OBRIGATORIAS_OFERTA
        if normalizar(campo) not in cabecalhos_norm
    ]
    if faltantes:
        raise ErroConversao(
            f"O CSV de oferta não possui as colunas obrigatórias: {faltantes}. "
            f"Colunas encontradas: {cabecalhos}"
        )

    def obter(linha: Dict[str, str], campo: str) -> str:
        coluna = cabecalhos_norm[normalizar(campo)]
        return str(linha.get(coluna, "")).strip()

    agrupadas: "OrderedDict[str, Dict[str, Any]]" = OrderedDict()
    turnos_usados: List[str] = []

    for linha in linhas:
        numero = linha.get("__linha_csv__", "?")
        id_turma = obter(linha, "id_turma")
        codigo = obter(linha, "codigo_disciplina").upper()
        nome_disc = obter(linha, "nome_disciplina")
        horas = parse_numero(obter(linha, "horas_semanais"), f"horas_semanais, linha {numero}")
        dia_raw = obter(linha, "dia")
        dia = dia_canonico(dia_raw)
        inicio = obter(linha, "horario_inicio")
        fim = obter(linha, "horario_fim")
        turno = obter(linha, "turno")

        if not id_turma:
            raise ErroConversao(f"id_turma vazio na linha {numero} da oferta.")
        if not codigo:
            raise ErroConversao(f"codigo_disciplina vazio na linha {numero} da oferta.")
        if not nome_disc:
            raise ErroConversao(f"nome_disciplina vazio na linha {numero} da oferta.")
        if horas <= 0:
            raise ErroConversao(
                f"A carga horária da turma {id_turma} deve ser positiva."
            )
        if not turno:
            raise ErroConversao(f"Turno vazio na linha {numero} da oferta.")

        primeiro_turno = turno.split("-", 1)[0].strip()
        if normalizar_dia(primeiro_turno) != normalizar_dia(dia):
            raise ErroConversao(
                f"O dia '{dia_raw}' não corresponde ao prefixo do turno '{turno}' "
                f"na turma {id_turma}, linha {numero}."
            )
        if "-" not in turno:
            raise ErroConversao(
                f"Turno '{turno}' inválido na turma {id_turma}; esperado Dia-periodo."
            )

        inicio_min = para_minutos(inicio, f"turma {id_turma}, linha {numero}")
        fim_min = para_minutos(fim, f"turma {id_turma}, linha {numero}")
        if fim_min <= inicio_min:
            raise ErroConversao(
                f"Horário final não posterior ao inicial na turma {id_turma}: "
                f"{inicio}–{fim}."
            )
        if fim_min - inicio_min != 30:
            raise ErroConversao(
                f"O slot da turma {id_turma}, linha {numero}, possui "
                f"{fim_min - inicio_min} minutos; esperava exatamente 30."
            )
        if inicio_min % 30 != 0 or fim_min % 30 != 0:
            raise ErroConversao(
                f"Slot fora da grade de 30 minutos na turma {id_turma}: {inicio}–{fim}."
            )

        if id_turma not in agrupadas:
            turma = {
                "id": id_turma,
                "disciplina": codigo,
                "nome_disciplina": nome_disc,
                "horas": horas,
                "slots": [],
            }
            # Metadados institucionais opcionais. Campos de professor na oferta
            # são deliberadamente ignorados: professores vêm somente do Forms.
            for campo_origem, campo_saida in (
                ("classe_origem", "classe_origem"),
                ("local", "local"),
                ("departamento", "departamento"),
                ("pagina_origem", "pagina_origem"),
            ):
                if normalizar(campo_origem) in cabecalhos_norm:
                    v = obter(linha, campo_origem)
                    if v:
                        turma[campo_saida] = v
            agrupadas[id_turma] = turma
        else:
            turma = agrupadas[id_turma]
            if turma["disciplina"] != codigo:
                raise ErroConversao(
                    f"A turma {id_turma} aparece vinculada a mais de um código de disciplina."
                )
            if normalizar(turma["nome_disciplina"]) != normalizar(nome_disc):
                raise ErroConversao(
                    f"A turma {id_turma} aparece com nomes de disciplina diferentes."
                )
            if abs(float(turma["horas"]) - horas) > 1e-9:
                raise ErroConversao(
                    f"A turma {id_turma} aparece com cargas horárias diferentes."
                )

        chave_slot = (dia, inicio)
        if any(
            (s["dia"], s["horario"]) == chave_slot
            for s in agrupadas[id_turma]["slots"]
        ):
            raise ErroConversao(
                f"Slot duplicado na turma {id_turma}: {dia} {inicio}."
            )

        agrupadas[id_turma]["slots"].append({
            "dia": dia,
            "horario": inicio,
            "horario_fim": fim,
            "turno": turno,
        })

        if turno not in turnos_usados:
            turnos_usados.append(turno)

    turmas = list(agrupadas.values())
    if not turmas:
        raise ErroConversao("O CSV de oferta não contém turmas.")

    # Ordena slots cronologicamente dentro de cada dia e turma.
    ordem_dia = {d: i for i, d in enumerate(["Seg", "Ter", "Qua", "Qui", "Sex", "Sab", "Dom"])}
    for turma in turmas:
        turma["slots"].sort(
            key=lambda s: (
                ordem_dia.get(s["dia"], 99),
                para_minutos(s["horario"]),
            )
        )

    return turmas, turnos_usados


# ---------------------------------------------------------------------------
# Processamento dos professores e construção da instância JSON
# ---------------------------------------------------------------------------

def construir_instancia(
    caminho_forms: Path,
    caminho_oferta: Path,
    caminho_saida: Path,
    carga_min_padrao: float = CARGA_MIN_PADRAO,
    carga_max_padrao: float = CARGA_MAX_PADRAO,
    id_instancia: Optional[str] = None,
    descricao: Optional[str] = None,
    delimitador_forms: Optional[str] = None,
    delimitador_oferta: Optional[str] = None,
) -> Dict[str, Any]:
    if carga_min_padrao < 0 or carga_max_padrao < carga_min_padrao:
        raise ErroConversao("Os limites de carga padrão são inválidos.")

    cabecalhos_forms, respostas = ler_csv(caminho_forms, delimitador_forms)
    colunas = descobrir_colunas_principais(cabecalhos_forms)
    colunas_pref, colunas_indisp = descobrir_colunas_grade(cabecalhos_forms)

    turmas, turnos = carregar_oferta_csv(caminho_oferta, delimitador_oferta)

    codigos_oferta = {str(t["disciplina"]).upper() for t in turmas}
    codigos_forms = set(colunas_pref)

    ausentes = sorted(codigos_oferta - codigos_forms)
    extras = sorted(codigos_forms - codigos_oferta)
    if ausentes or extras:
        partes = []
        if ausentes:
            partes.append(
                "Códigos existentes na oferta sem coluna de preferência no Forms: "
                + ", ".join(ausentes)
            )
        if extras:
            partes.append(
                "Códigos com preferência no Forms que não aparecem na oferta: "
                + ", ".join(extras)
            )
        raise ErroConversao(
            "; ".join(partes)
            + ". Corrija a grade do Forms ou a oferta. O conversor não atribui "
              "preferência zero automaticamente para disciplinas ausentes."
        )

    professores: List[Dict[str, Any]] = []
    dados_docentes: List[Dict[str, Any]] = []
    emails_vistos = set()

    for indice, resposta in enumerate(respostas, start=1):
        linha_csv = resposta.get("__linha_csv__", "?")
        nome = resposta.get(colunas["nome"], "").strip()
        email = resposta.get(colunas["email"], "").strip()

        if not nome:
            raise ErroConversao(f"Nome vazio na linha {linha_csv} do Forms.")
        if not email:
            raise ErroConversao(f"E-mail vazio na linha {linha_csv} do Forms.")

        chave_email = normalizar(email)
        if chave_email in emails_vistos:
            raise ErroConversao(
                f"E-mail duplicado nas respostas: '{email}', linha {linha_csv}."
            )
        emails_vistos.add(chave_email)

        # A identidade dos professores vem exclusivamente das respostas do Forms.
        professor_id = f"P{indice:03d}"

        possui_limites = resposta_sim(
            resposta.get(colunas["limites"], ""),
            f"pergunta sobre limites individuais, professor {nome}, linha {linha_csv}",
        )

        if possui_limites:
            if vazio(resposta.get(colunas["carga_min"], "")):
                raise ErroConversao(
                    f"{nome} respondeu que possui limites individuais, mas não "
                    "informou a carga horária mínima."
                )
            if vazio(resposta.get(colunas["carga_max"], "")):
                raise ErroConversao(
                    f"{nome} respondeu que possui limites individuais, mas não "
                    "informou a carga horária máxima."
                )
            carga_min = parse_numero(
                resposta[colunas["carga_min"]],
                f"carga mínima de {nome}",
            )
            carga_max = parse_numero(
                resposta[colunas["carga_max"]],
                f"carga máxima de {nome}",
            )
        else:
            carga_min = float(carga_min_padrao)
            carga_max = float(carga_max_padrao)

        if carga_max < carga_min:
            raise ErroConversao(
                f"A carga máxima ({carga_max}) é menor que a mínima ({carga_min}) "
                f"para {nome}."
            )

        preferencias: Dict[str, int] = {}
        for codigo, coluna in colunas_pref.items():
            preferencias[codigo] = parse_preferencia(
                resposta.get(coluna, ""),
                f"{nome}, {codigo}, linha {linha_csv}",
            )

        indisponibilidades: Dict[str, List[Tuple[int, int]]] = {}
        for dia, coluna in colunas_indisp.items():
            indisponibilidades[dia] = parse_faixas_indisponiveis(
                resposta.get(coluna, ""),
                f"{nome}, {dia}, linha {linha_csv}",
            )

        professores.append({
            "id": professor_id,
            "nome": nome,
            "carga_min": float(carga_min),
            "carga_max": float(carga_max),
            "afastado": False,
            "email": email,
        })
        dados_docentes.append({
            "id": professor_id,
            "nome": nome,
            "preferencias": preferencias,
            "indisponibilidades": indisponibilidades,
            "possui_limites_individuais": possui_limites,
        })

    if not professores:
        raise ErroConversao("Nenhum professor foi encontrado no CSV do Forms.")

    pares: List[Dict[str, Any]] = []
    quantidade_inelegiveis = 0
    quantidade_indisponiveis = 0

    for docente in dados_docentes:
        for turma in turmas:
            codigo = str(turma["disciplina"]).upper()
            preferencia = docente["preferencias"][codigo]
            qualificado = preferencia > 0

            dia_e_intervalos = docente["indisponibilidades"]
            indisponivel = False

            for slot in turma["slots"]:
                dia = normalizar_dia(slot["dia"])
                inicio = para_minutos(slot["horario"])
                fim = para_minutos(slot["horario_fim"])

                for bloqueio_inicio, bloqueio_fim in dia_e_intervalos.get(dia, []):
                    # Intervalos semiabertos: [início, fim).
                    if inicio < bloqueio_fim and bloqueio_inicio < fim:
                        indisponivel = True
                        break
                if indisponivel:
                    break

            disponivel = not indisponivel

            if not qualificado:
                quantidade_inelegiveis += 1
            if not disponivel:
                quantidade_indisponiveis += 1

            pares.append({
                "professor": docente["id"],
                "turma": turma["id"],
                "qualificado": bool(qualificado),
                "disponivel": bool(disponivel),
                "preferencia": int(preferencia),
            })

    resultado = {
        "id": id_instancia or "papt_forms_oferta",
        "descricao": descricao or (
            "Instância PAPT construída a partir das respostas do Google Forms "
            "e da oferta institucional em CSV."
        ),
        "turnos_semanais": turnos,
        "professores": professores,
        "turmas": turmas,
        "pares_professor_turma": pares,
        "resumo_conversao": {
            "arquivo_forms": caminho_forms.name,
            "arquivo_oferta": caminho_oferta.name,
            "quantidade_professores": len(professores),
            "quantidade_turmas": len(turmas),
            "quantidade_disciplinas": len(codigos_oferta),
            "quantidade_slots": sum(len(t["slots"]) for t in turmas),
            "quantidade_turnos": len(turnos),
            "quantidade_pares_professor_turma": len(pares),
            "quantidade_pares_nao_qualificados": quantidade_inelegiveis,
            "quantidade_pares_indisponiveis": quantidade_indisponiveis,
            "regra_qualificacao": "qualificado quando preferência > 0",
            "regra_disponibilidade": (
                "disponível quando nenhum slot da turma se sobrepõe a uma "
                "faixa marcada como indisponível"
            ),
            "regra_limites_carga": (
                "resposta Sim: utiliza mínimo e máximo informados; "
                "resposta Não: utiliza os limites padrão configurados"
            ),
            "limite_minimo_padrao": float(carga_min_padrao),
            "limite_maximo_padrao": float(carga_max_padrao),
            "professores_na_oferta": "não utilizado; professores vêm exclusivamente do Forms",
        },
    }

    # Validações estruturais para o carregador Julia original.
    ids_prof = [p["id"] for p in professores]
    ids_turmas = [t["id"] for t in turmas]
    if len(ids_prof) != len(set(ids_prof)):
        raise ErroConversao("IDs de professores duplicados.")
    if len(ids_turmas) != len(set(ids_turmas)):
        raise ErroConversao("IDs de turmas duplicados.")
    if set(resultado["turnos_semanais"]) != {
        s["turno"] for t in turmas for s in t["slots"]
    }:
        raise ErroConversao("Inconsistência no conjunto turnos_semanais.")

    caminho_saida.parent.mkdir(parents=True, exist_ok=True)
    with caminho_saida.open("w", encoding="utf-8") as arquivo:
        json.dump(resultado, arquivo, ensure_ascii=False, indent=2)
        arquivo.write("\n")

    return resultado


# ---------------------------------------------------------------------------
# Interface de linha de comando
# ---------------------------------------------------------------------------

def argumentos() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description=(
            "Converte o CSV de respostas do Google Forms e o CSV da oferta "
            "institucional em uma instância JSON do PAPT."
        )
    )
    parser.add_argument(
        "--csv", required=True, type=Path,
        help="CSV exportado do Google Forms/Sheets (dados dos professores).",
    )
    parser.add_argument(
        "--oferta", required=True, type=Path,
        help="CSV da oferta institucional (turmas e slots de 30 minutos).",
    )
    parser.add_argument(
        "--saida", default=Path("instancia_papt_forms.json"), type=Path,
        help="Caminho do JSON a ser gerado.",
    )
    parser.add_argument(
        "--carga-min-padrao", type=float, default=CARGA_MIN_PADRAO,
        help=f"Carga mínima padrão para quem respondeu Não (padrão: {CARGA_MIN_PADRAO}).",
    )
    parser.add_argument(
        "--carga-max-padrao", type=float, default=CARGA_MAX_PADRAO,
        help=f"Carga máxima padrão para quem respondeu Não (padrão: {CARGA_MAX_PADRAO}).",
    )
    parser.add_argument("--id-instancia", default=None, help="ID opcional da instância.")
    parser.add_argument("--descricao", default=None, help="Descrição opcional da instância.")
    parser.add_argument(
        "--delimitador-forms", default=None,
        help="Delimitador explícito do CSV Forms: ',', ';' ou '\\t'.",
    )
    parser.add_argument(
        "--delimitador-oferta", default=None,
        help="Delimitador explícito do CSV de oferta: ',', ';' ou '\\t'.",
    )
    return parser.parse_args()


def main() -> int:
    args = argumentos()
    try:
        resultado = construir_instancia(
            caminho_forms=args.csv,
            caminho_oferta=args.oferta,
            caminho_saida=args.saida,
            carga_min_padrao=args.carga_min_padrao,
            carga_max_padrao=args.carga_max_padrao,
            id_instancia=args.id_instancia,
            descricao=args.descricao,
            delimitador_forms=args.delimitador_forms,
            delimitador_oferta=args.delimitador_oferta,
        )
    except (ErroConversao, OSError, csv.Error, json.JSONDecodeError) as exc:
        print(f"ERRO: {exc}", file=sys.stderr)
        return 1

    resumo = resultado["resumo_conversao"]
    print("Instância PAPT gerada com sucesso.")
    print(f"Arquivo: {args.saida.resolve()}")
    print(f"Professores: {resumo['quantidade_professores']}")
    print(f"Disciplinas: {resumo['quantidade_disciplinas']}")
    print(f"Turmas: {resumo['quantidade_turmas']}")
    print(f"Slots de 30 minutos: {resumo['quantidade_slots']}")
    print(f"Turnos: {resumo['quantidade_turnos']}")
    print(f"Pares professor-turma: {resumo['quantidade_pares_professor_turma']}")
    print(
        "Pares não qualificados: "
        f"{resumo['quantidade_pares_nao_qualificados']}"
    )
    print(
        "Pares indisponíveis: "
        f"{resumo['quantidade_pares_indisponiveis']}"
    )
    print(
        "Observação: confirme que as disciplinas do Forms cobrem todos os "
        "códigos da oferta e que os limites padrão de carga são adequados."
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
