# Gerador de instâncias sintéticas do PAPT

Gera instâncias de teste em JSON para o problema de atribuição de professores a turmas (PAPT). Cada instância contém professores, turmas com horários, pares professor–turma (qualificação, disponibilidade, preferência) e limites de carga horária semanal.

**Garantia de viabilidade:** antes de sortear qualquer restrição, o gerador monta uma *atribuição-testemunha* (uma solução viável conhecida). Todas as restrições sorteadas depois são compatíveis com ela. Portanto, toda instância gerada tem pelo menos uma solução viável, salvo alterações manuais no JSON.

## Uso rápido

PowerShell (continuação de linha com acento grave):

```powershell
python ferramentas\gerar_instancias.py `
  --saida modelo\projeto_ic\model_ic\instancias `
  --nome sintetica_media `
  --professores 6 `
  --disciplinas 4 `
  --turmas-por-disciplina 3 `
  --horas-por-turma 4 `
  --slots-por-turma 2 `
  --densidade-qualificacao 0.60 `
  --disponibilidade 0.80 `
  --perfil-preferencia uniforme `
  --modo-carga aleatoria `
  --carga-minima 6 `
  --carga-maxima 12 `
  --conflitos medio `
  --semente 42
```

No CMD, use `^` no lugar do acento grave. Todos os parâmetros têm valor padrão; `python ferramentas\gerar_instancias.py --help` lista as opções.

Exemplo de cenário: *o colegiado precisa distribuir 12 turmas entre 6 professores; alguns só podem lecionar certas disciplinas, alguns estão indisponíveis em certos horários e há limites de carga horária.*

## Parâmetros

### Arquivo de saída

| Parâmetro | Padrão | Descrição |
|---|---|---|
| `--saida` | `instancias` | Pasta onde o JSON é salvo. Criada automaticamente se não existir. |
| `--nome` | `sintetica` | Nome base do arquivo (`<saida>\<nome>.json`) e valor do campo `id` da instância. |

### Tamanho da instância

| Parâmetro | Padrão | Descrição |
|---|---|---|
| `--professores` | 6 | Número de professores (`P01`, `P02`, ...). |
| `--disciplinas` | 4 | Número de disciplinas (`DISC01`, `DISC02`, ...). |
| `--turmas-por-disciplina` | 3 | Turmas de cada disciplina. O total de turmas é `disciplinas × turmas-por-disciplina` (ex.: 4 × 3 = 12). |
| `--horas-por-turma` | 4.0 | Carga horária semanal de cada turma, em horas. |
| `--slots-por-turma` | 2 | Encontros semanais por turma (de 1 a 5). Cada encontro cai em um dia diferente. |

**Regra:** o total de turmas deve ser maior ou igual ao número de professores, para que todos tenham carga positiva.

### Qualificação, disponibilidade e preferência

Valem para os pares professor–turma que **não** fazem parte da atribuição-testemunha. Na testemunha, o professor é sempre qualificado e disponível.

| Parâmetro | Padrão | Descrição |
|---|---|---|
| `--densidade-qualificacao` | 0.60 | Probabilidade (0 a 1) de um professor ser qualificado para uma turma. Valores menores deixam o problema mais restrito. |
| `--disponibilidade` | 0.80 | Probabilidade (0 a 1) de um professor estar disponível nos horários de uma turma. 0.80 significa cerca de 20% de indisponibilidades. |
| `--perfil-preferencia` | `uniforme` | Distribuição da nota de preferência (0 a 5) de cada par. Veja abaixo. |

Qualificação e disponibilidade são sorteadas de forma independente. A preferência só vale quando o par é qualificado **e** disponível; caso contrário, é gravada como 0.

Perfis de preferência:

| Perfil | Notas sorteadas |
|---|---|
| `uniforme` | Inteiros de 0 a 5 |
| `alta` | Inteiros de 3 a 5 |
| `baixa` | Inteiros de 0 a 2 |
| `polarizada` | Apenas 0 ou 5 |
| `moderada` | Inteiros de 2 a 4 |

### Conflitos de horário

| Parâmetro | Padrão | Descrição |
|---|---|---|
| `--conflitos` | `medio` | Define o universo de horários disponíveis. Quanto menor o universo, mais turmas se sobrepõem. |

| Nível | Horários por dia | Universo (5 dias) |
|---|---|---|
| `baixo` | 07:30, 09:30, 13:30, 15:30, 17:30 | 25 slots |
| `medio` | 09:30, 11:30, 13:30, 15:30 | 20 slots |
| `alto` | 09:30, 15:30, 17:30 | 15 slots |

Horários antes das 12:00 pertencem ao turno matutino (`mat`); os demais, ao vespertino (`vesp`). Na atribuição-testemunha, as turmas de um mesmo professor nunca ocupam o mesmo dia e horário. Se o gerador não conseguir distribuir os horários (universo pequeno demais para o número de turmas por professor), ele avisa e sugere usar `--conflitos baixo`.

### Capacidade (limites de carga horária)

| Parâmetro | Padrão | Descrição |
|---|---|---|
| `--modo-carga` | `aleatoria` | `fixa` ou `aleatoria`. |
| `--carga-minima` | 6.0 | Menor carga semanal permitida, em horas. |
| `--carga-maxima` | 12.0 | Maior carga semanal permitida, em horas. |

- **`fixa`:** todos os professores recebem exatamente `carga_min = --carga-minima` e `carga_max = --carga-maxima`.
- **`aleatoria`:** cada professor recebe limites próprios, sorteados dentro de `[--carga-minima, --carga-maxima]` e sempre contendo a carga da atribuição-testemunha. Isso cria professores com mais ou menos folga.

**Como escolher a faixa:** as turmas são distribuídas em rodízio entre os professores, então cada um recebe `⌊turmas/professores⌋` ou `⌈turmas/professores⌉` turmas na testemunha. A carga-testemunha é esse número multiplicado por `--horas-por-turma`. A faixa `[carga-minima, carga-maxima]` precisa conter esses valores. Com 12 turmas, 6 professores e 4 h por turma, cada professor tem 8 h na testemunha, e a faixa 6–12 h serve.

Equivalências aproximadas para este cenário:

| Rigidez | Parâmetros |
|---|---|
| Estrita | `--modo-carga fixa --carga-minima 8 --carga-maxima 8` |
| Moderada | `--modo-carga aleatoria --carga-minima 6 --carga-maxima 12` |
| Folgada | `--modo-carga aleatoria --carga-minima 0 --carga-maxima 16` |

Se a faixa não comportar a carga-testemunha, o gerador aborta antes de criar o arquivo, com uma mensagem como:

```
Com 12 turmas e 6 professores, alguns professores teriam 8 h,
acima da carga maxima de 6 h. Reduza turmas/horas por turma ou aumente a carga maxima.
```

### Reprodutibilidade

| Parâmetro | Padrão | Descrição |
|---|---|---|
| `--semente` | 42 | Semente do gerador aleatório. A mesma semente e os mesmos parâmetros produzem sempre o mesmo JSON. |

## Formato do JSON gerado

```json
{
  "id": "sintetica_media",
  "descricao": "...",
  "criterios_geracao": { "semente": 42, "professores": 6, "modo_carga": "aleatoria", "...": "..." },
  "turnos_semanais": ["Seg-mat", "Seg-vesp", "..."],
  "professores": [
    { "id": "P01", "nome": "Professor 01", "carga_min": 6.72, "carga_max": 9.38, "afastado": false }
  ],
  "turmas": [
    {
      "id": "DISC01-T01",
      "disciplina": "DISC01",
      "horas": 4.0,
      "slots": [
        { "dia": "Seg", "horario": "09:30", "turno": "Seg-mat" },
        { "dia": "Qua", "horario": "15:30", "turno": "Qua-vesp" }
      ]
    }
  ],
  "pares_professor_turma": [
    { "professor": "P01", "turma": "DISC01-T01", "qualificado": true, "disponivel": true, "preferencia": 3 }
  ]
}
```

| Campo | Conteúdo |
|---|---|
| `criterios_geracao` | Todos os parâmetros usados, para reproduzir a instância. |
| `turnos_semanais` | Os 10 turnos da semana (`Seg-mat`, `Seg-vesp`, ..., `Sex-vesp`). |
| `professores` | Identificação e limites de carga semanal (`carga_min`, `carga_max`). `afastado` é sempre `false` nas instâncias geradas. |
| `turmas` | Disciplina, horas semanais e horários (dia, hora e turno de cada encontro). |
| `pares_professor_turma` | Um registro para cada combinação professor × turma (6 × 12 = 72 no exemplo). |

## Observações

- A atribuição-testemunha **não** é gravada no JSON; ela só garante a viabilidade durante a geração.
- Os percentuais de qualificação e disponibilidade se aplicam apenas aos pares fora da testemunha. A proporção real no arquivo fica um pouco acima do valor informado.
- Se você editar o JSON manualmente (remover qualificações, reduzir limites etc.), a garantia de viabilidade deixa de valer.
- Combinações inviáveis (limites incompatíveis com o número de turmas, probabilidades fora de 0–1, `--horas-por-turma` não positivo, entre outras) são rejeitadas com mensagem explicativa, sem gerar arquivo.
