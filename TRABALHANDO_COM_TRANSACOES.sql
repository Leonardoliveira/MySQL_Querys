#SELECIONANDO O BANCO
USE tw_nfe;

#CRIANDO UMA PROCEDURE QUE REGISTRA COMPRA
DELIMITER $$
CREATE PROCEDURE sp_registrar_compra(IN p_valor_pago DECIMAL, 
									 IN p_cli_id BIGINT, 
                                     IN p_prd_id BIGINT,
                                     IN p_quantidade INT,
                                     IN p_preco DECIMAL)
BEGIN 
	#INICIANDO UMA TRANSAÇÃO 
    #DECLARANDO UM handler PARA IDENTIFICAR ERROS
    DECLARE v_cmp_id BIGINT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION 
    BEGIN
		ROLLBACK;
        SELECT 'ATENÇÃO! PARECE QUE IDENTIFICAMOS UM ERRO.';
    END;
    START TRANSACTION;
    INSERT INTO cmp_compras
    (cmp_data_hora, cmp_valor_pago, cli_id) VALUES
    (NOW(), p_valor_pago, p_cli_id);
    SET v_cmp_id = LAST_INSIDE_ID();
    INSERT INTO cmp_prd_compras_produtos
	VALUES (p_prd_id, v_cmp_id, p_quantidade, p_preco);
		COMMIT;
        SELECT 'PROCESSO FINALIZADO!';
END $$
DELIMITER ;
#SELECIONANADO TABELAS
SELECT * FROM cmp_compras;
SELECT * FROM cmp_prd_compras_produtos;
SELECT * FROM tw_nfe.cli_clientes;
SELECT * FROM tw_nfe.prd_produtos;
#SELECIONANADO O ULTIMO ID
SELECT LAST_INSERT_ID();

#CHAMADO A SP
CALL sp_registrar_compra(200, 3, 1, 1, 150);