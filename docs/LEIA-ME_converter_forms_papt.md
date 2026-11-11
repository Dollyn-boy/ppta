# Conversor Google Forms → instância JSON do PAPT

## Arquivos necessários

- `converter_forms_papt.py`: conversor.
- `respostas_forms.csv`: exportação do Google Sheets vinculado ao Google Forms.
- `oferta_base.json`: JSON institucional com `turnos_semanais` e `turmas`, incluindo disciplinas, cargas e horários/slots.

O CSV não contém a oferta de turmas nem seus horários. Por isso, o conversor combina as respostas dos professores com o JSON-base da oferta.

## Execução

```bash
python converter_forms_papt.py \
  --csv respostas_forms.csv \
  --base oferta_base.json \
  --saida instancia_papt.json \
  --carga-max-padrao 12
```

Se estiver usando a oferta 2026.2 já existente no projeto, o comando pode ser:

```bash
python converter_forms_papt.py \
  --csv respostas_forms.csv \
  --base oferta_uefs_2026_2_papt.json \
  --saida instancia_papt_real.json \
  --carga-max-padrao 12
```

## Relação entre os campos

- `Nome completo` e `E-mail institucional`: identificam cada respondente.
- Colunas da grade `Qual é sua preferência... [DISCIPLINA]`: cada resposta é interpretada como um número de 0 a 5.
- Colunas da grade `Em quais dias... [DIA]`: cada faixa marcada é interpretada como período indisponível.
- Carga mínima: vem da resposta obrigatória do professor.
- Carga máxima: vem da resposta, se preenchida; se ficar vazia, usa a carga máxima do professor no JSON-base. Para um docente que não exista no JSON-base, usa `--carga-max-padrao` (12 por padrão).

A qualificação é derivada da preferência: `preferencia > 0`. A disponibilidade é calculada comparando as faixas indisponíveis do docente com os slots de cada turma.

## Mapeamento das disciplinas

O conversor tenta associar automaticamente o rótulo da disciplina no Forms ao código `turma["disciplina"]`, comparando-o com o código ou com `turma["nome_disciplina"]` do JSON-base.

Se o texto do Forms não corresponder, ou corresponder a mais de um código, informe um arquivo JSON com o mapeamento explícito:

```json
{
  "Nome da disciplina como aparece no Forms": "CODIGO_NO_JSON_BASE"
}
```

Exemplo de mapeamento de disciplinas com nomes repetidos na oferta 2026.2: `mapa_disciplinas_exemplo_2026_2.json`. Para utilizá-lo, acrescente `--mapa-disciplinas mapa_disciplinas_exemplo_2026_2.json` e configure as linhas do Forms com os mesmos rótulos do arquivo.

## IDs e afastamentos

Quando o nome do respondente corresponder a um professor do JSON-base (ignorando diferenças de maiúsculas/minúsculas e acentos), o ID existente é reaproveitado e o campo `afastado` é preservado. Para um novo docente, o conversor gera o próximo ID `Pxxx` e define `afastado: false`, pois o formulário atual não pergunta sobre afastamento.

Se o nome estiver escrito de forma diferente, o professor pode ser tratado como novo. Revise a lista `professores` gerada antes de executar o modelo.

## Granularidade da disponibilidade

O arquivo atual `criar_formulario_papt.gs` usa faixas de duas horas (`07h–09h`, `09h–11h` etc.). Marcar uma faixa significa que o professor está indisponível durante todo esse intervalo. O conversor cruza esse intervalo com os slots de 30 minutos da oferta: qualquer sobreposição torna a turma indisponível para aquele professor.

Para coletar disponibilidade com precisão de meia hora, altere `FAIXAS_HORARIAS` no Apps Script para opções de 30 minutos, por exemplo `07:00–07:30`, `07:30–08:00` etc. O conversor aceita tanto faixas de duas horas quanto de 30 minutos.

## JSON produzido

O arquivo final conserva `turnos_semanais` e `turmas` do JSON-base e substitui:

- `professores`: respondentes do Forms, com `id`, `nome`, `carga_min`, `carga_max` e `afastado`;
- `pares_professor_turma`: todas as combinações entre respondentes e turmas, contendo `professor`, `turma`, `qualificado`, `disponivel` e `preferencia`.

Essa estrutura é compatível com o carregador Julia `carregar_instancia()` descrito no projeto.
