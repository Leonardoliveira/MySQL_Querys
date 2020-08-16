#SELECIONANDO O BANCO
USE tw_nfe;

#CRIANDO TABELA DE LOGS
CREATE TABLE log_logs(
	log_mensagem VARCHAR(1000) NOT NULL
);

#CRIANDO TRIGGER
DELIMITER $$
CREATE TRIGGER tr_registra_compra AFTER INSERT ON cmp_compras
FOR EACH ROW
BEGIN
	INSERT INTO log_logs(log_mensagem) VALUES (CONCAT('COMPRA REALIZADA EM ', DATE_FORMAT(NEW.cmp_data_hora, '%d/%M/%Y %H:%m:%s')));
END $$
DELIMITER ;
#inserindo dados 
INSERT INTO cmp_compras 
(cmp_data_hora, cmp_valor_pago, cli_id) VALUES
(now(), 125.00,1);

#selecionando a tabela de log
SELECT * FROM log_logs;
