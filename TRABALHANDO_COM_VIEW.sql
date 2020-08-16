
#CRIANDO UMA VIEW
CREATE OR REPLACE VIEW vw_relatorio_clientes AS
SELECT  cli.cli_id, cli.cli_nome, 
		COALESCE(SUM(DISTINCT( cmp.cmp_valor_pago)), 0) AS 'Somando Tudo',
		COUNT(DISTINCT (cmp.cmp_id)) 'Qtd de Compras',
        AVG(cmp_prd.cmp_prd_quantidade * cmp_prd.cmp_prd_preco) 'Média da Compra'
FROM cli_clientes cli
LEFT JOIN cmp_compras cmp
ON cli.cli_id = cmp.cli_id
INNER JOIN cmp_prd_compras_produtos cmp_prd
ON cmp_prd.cmp_id = cmp.cmp_id
INNER JOIN prd_produtos prd
ON cmp_prd.prd_id = prd.prd_id
GROUP BY cli.cli_id
HAVING COUNT(cmp_prd.cmp_id) > 1;

#SELECIONANDO A VIEW
SELECT * FROM vw_relatorio_clientes;