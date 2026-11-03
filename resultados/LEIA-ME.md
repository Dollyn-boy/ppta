# Resultados de execução

Este diretório recebe os arquivos gerados por `PAPT_JuMP.jl`:

- `ID.lp`: modelo linear exportado para inspeção;
- `ID_resultado.json`: métricas e alocações da instância;
- `resumo_execucoes.csv`: resumo consolidado das instâncias executadas na mesma chamada.

Os resultados são artefatos de execução e podem ser recriados. Antes de uma rodada importante, arquive uma cópia junto com o ID/versionamento do JSON, a configuração do solver e o log do terminal. Evite misturar resultados de diferentes versões de formulação no mesmo relatório.
