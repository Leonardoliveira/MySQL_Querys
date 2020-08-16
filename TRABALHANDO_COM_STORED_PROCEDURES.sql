#SELECIONANDO O BANCO
USE tw_nfe;
#ATRIBUINDO O DELIMITADOR
DELIMITER $$
#CRIANDO A PROCEDURE
CREATE PROCEDURE sp_ola(IN p_nome VARCHAR(100))
	BEGIN
		SELECT CONCAT('Olá, ' , p_nome) AS 'MENSAGEM';
	END $$
DELIMITER ;

DROP PROCEDURE sp_ola;
#CHAMANDO SP
CALL sp_ola('Leonardo');

#TRABALHANDO COM CURSORES
#CRIANDO TABELA
CREATE TABLE dw_relatorios_clientes(
	cli_nome VARCHAR(100),
    valor_pago DECIMAL(8, 2),
    quantidade_de_compras INT,
    media_preco_produto DECIMAL NOT NULL
);

#SELECIONANDO A TABELA
SELECT * FROM dw_relatorios_clientes;

DELIMITER $$
#CRIANDO UMA PROCEDURE PARA VARRER A TABELA
CREATE PROCEDURE sp_relatorio_clientes(OUT p_linhas_processadas INT)
BEGIN

	#DECLARANDO VARIAVEIS
	DECLARE v_nome_cliente VARCHAR(100);
    DECLARE v_valor_pago DECIMAL(8,2);
    DECLARE v_quantidade_compras INT;
    DECLARE v_media_preco_produto 	DECIMAL;
    DECLARE v_finalizado INTEGER DEFAULT 0;
    
    #DECLARANDO OS CURSORES
    DECLARE cr_relatorio_clientes CURSOR FOR
		SELECT * FROM vw_relatorio_clientes;
        
	#PARA NÃO GERAR ERRO AO FINALIZAR A VARREDURA 
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_finalizado = 1;
    SET p_linhas_processadas = 0;
    DELETE FROM dw_relatorios_clientes;
    OPEN cr_relatorio_clientes;
    loop_relatorio_clientes: LOOP
	FETCH cr_relatorio_clientes INTO v_nome_cliente, v_valor_pago, 
									v_quantidade_compras, v_media_preco_produto;
                                        
	#VERIFICANDO SE TERMINOU O LOOP
		IF v_finalizado = 1 THEN
			LEAVE loop_relatorio_clientes;
		END IF;
			
		#INSERINDO OS DADOS NA TABELA DW
		INSERT INTO dw_relatorios_clientes 
		VALUES(v_nome_cliente, v_valor_pago, v_quantidade_compras, v_media_preco_produto);
		SET p_linhas_processadas = p_linhas_processadas + 1;
		END LOOP loop_relatorio_clientes;
	CLOSE cr_relatorio_clientes;    
END$$

DELIMITER ;

#TESTANDO A SP
SELECT * FROM dw_relatorios_clientes;

CALL sp_relatorio_clientes(@v_linhas_processadas);
