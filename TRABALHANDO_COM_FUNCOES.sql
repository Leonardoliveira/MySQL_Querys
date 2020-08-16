#USANDO O BANCO
USE tw_nfe;

#Habilitando a função
SET GLOBAL log_bin_trust_function_creators = 1;

#CRIANDO UMA FUNÇÃO
CREATE FUNCTION fn_ola()
RETURNS VARCHAR(10)
	RETURN 'Olá Mundo!';
    
#CHAMANDO A FUNÇÃO
SELECT fn_ola();

#CRIANDO FUNÇÃO COMPARAMENTRO

DELIMITER $$

CREATE FUNCTION fn_calcular_valor_compra(p_id_compra BIGINT)
	RETURNS DECIMAL(8,2)
    BEGIN
		#DECLARANDO VARIAVEL DO TIPO DECIMAL
		DECLARE v_valor_compra DECIMAL(8,2);
		SELECT SUM(cmp_prd_quantidade * cmp_prd_preco)
        INTO v_valor_compra
		FROM cmp_prd_compras_produtos 
		WHERE cmp_id = p_id_compra;
        RETURN 	v_valor_compra;
    END $$
    
DELIMITER ;

#TESTANDO A FUNÇÃO
SELECT * FROM cmp_prd_compras_produtos;

SELECT fn_calcular_valor_compra(1);

SELECT DISTINCT fn_calcular_valor_compra(cmp_id)
FROM cmp_prd_compras_produtos;
