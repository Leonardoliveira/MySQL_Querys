SELECT * FROM cli_clientes;
SELECT * FROM cmp_compras;

#INSERINDO DADOS NA TABELA COMPRAS
INSERT INTO cmp_compras (cmp_data_hora, cmp_valor_pago, cli_id) VALUES
(NOW(), 150.00, 1);
#INSERINDO DADOS NA TABELA COMPRAS
INSERT INTO cmp_compras (cmp_data_hora, cmp_valor_pago, cli_id) VALUES
(NOW(), 75.00, 2);

#FAZENDO SELECT DE DUAS TABELAS
SELECT cli.cli_nome, cli.cli_cpf, cmp.cmp_data_hora,
	   cmp.cmp_valor_pago	
FROM cli_clientes AS cli, cmp_compras AS cmp
WHERE cli.cli_id = cmp.cli_id;

#DESENVOLVENDO JOINS
#INNER JOIN
SELECT *
FROM cli_clientes cli
INNER JOIN cmp_compras cmp
ON cli.cli_id = cmp.cli_id
WHERE cmp.cmp_valor_pago >= 100.00;

#LEFT JOIN
SELECT cli.cli_nome, 
	   cli.cli_cpf,
       cmp.cmp_data_hora,
       COALESCE(cmp.cmp_valor_pago, 0)
FROM  cli_clientes cli
LEFT JOIN cmp_compras cmp
ON  cli.cli_id = cmp.cli_id
WHERE cmp.cmp_data_hora IS NULL;

#RIGHT JOIN
SELECT  cli.cli_nome, 
	   cli.cli_cpf,
       cmp.cmp_data_hora,
       COALESCE(cmp.cmp_valor_pago, 0)
FROM    cmp_compras cmp
RIGHT JOIN cli_clientes cli
ON   cmp.cli_id = cli.cli_id ;

