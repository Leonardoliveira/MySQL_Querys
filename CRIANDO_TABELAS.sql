#HABILITANDO O BANCO
USE tw_nfe;

#CRIANDO A TABELA DE CLIENTES
/*
Informações para guadar: Nome, Data de Nascimento, logradouro
*/
CREATE TABLE cli_clientes
(
		#TIPO SERIAL = BIGINT, NOT NULL, AUTO_INCREMENT, UNSIGNED E UNIQUE
		cli_id SERIAL PRIMARY KEY,
        cli_nome VARCHAR(50) NOT NULL,
        cli_data_nascimento DATE,
        cli_logradoura VARCHAR(200)
);

#DELETANDO TABELAS
DROP TABLE cli_clientes;

#INSERINDO DADOS NA TABELA CLIENTE
INSERT INTO cli_clientes 
(cli_nome, cli_data_nascimento, cli_logradoura) 
VALUES 
('TreinaWeb Tecnologia', '2006-01-01', 'Avenida Paulista, n° 1000');
INSERT INTO cli_clientes 
(cli_nome) 
VALUES 
('TreinaWeb Tecnologia 2');

#SELECIONANDO OS DADOS DA TABELA
SELECT * FROM cli_clientes;

#SELECIONANDO DADOS NA TABELA COM WHERE
SELECT * FROM cli_clientes
WHERE cli_id =  1;

SELECT * FROM cli_clientes
WHERE cli_data_nascimento IS NULL;

#ADICIONANDO A COLUNA DE CPF
ALTER TABLE cli_clientes
ADD cli_cpf CHAR(14) NOT NULL DEFAULT '-' AFTER cli_nome ;

#REMOVENDO A COLUNA DE CPF
ALTER TABLE cli_clientes
DROP COLUMN cli_cpf;

#INSERINDO MAIS UM CLIENTE
INSERT INTO cli_clientes 
(cli_nome, cli_cpf, cli_data_nascimento, cli_logradoura )
VALUES
('João da Silva', '123.456.789-01', '2010-01-01', 'Rua Teste, 154');
#OCULTANDO CPF
INSERT INTO cli_clientes 
(cli_nome, cli_data_nascimento, cli_logradoura )
VALUES
('Maria da Silva', '2012-01-01', 'Avenida Teste, 154');

#CORRIGINDO O ENDEREÇO DA MARIA
UPDATE cli_clientes
SET cli_logradoura = 'Avenida Teste, 156'
WHERE cli_id = 4; 

#ATUALIZANDO ALGUNS REGISTROS
UPDATE cli_clientes
SET cli_cpf = '345.567.890-12'
WHERE cli_id = 4;

#ALTERANDO A TABELA PARA UMA CONSTRAINT NO CPF
ALTER TABLE cli_clientes
ADD CONSTRAINT UN_CLI_CLIENTES__CLI_CPF UNIQUE(cli_cpf);

#APAGANDO CONSTRAINT 
ALTER TABLE cli_clientes
DROP CONSTRAINT CLI_UNIQUE;

SELECT * FROM cli_clientes;

#CONSULTANDO CLIENTES QUE NÃO POSSUEM DATA DE NASCIMENTO OU LOGRADOURO
SELECT * FROM 
cli_clientes
WHERE cli_data_nascimento IS NULL 
OR cli_logradoura IS NULL;

#ATUALIZANDO O LOGRADOURO DA MARIA PARA NULL
UPDATE cli_clientes
SET cli_logradoura = NULL 
WHERE cli_id = 4;

#ALTERANDO O NOME DO CAMPO DE CLI_LOGRADOURA PARA CLI_LOGRADOURO
ALTER TABLE cli_clientes
CHANGE cli_logradoura cli_logradouro VARCHAR(200);

desc cli_clientes;

#SELECIONANDO NOMES QUE COMECEM COM A LETRA 'T'
SELECT * FROM cli_clientes
WHERE cli_nome LIKE 't%';

INSERT INTO cli_clientes 
(cli_nome, cli_cpf, cli_data_nascimento, cli_logradouro )
VALUES
('Markos', '555.555.555-55', '1980-01-01', 'Rua Teste 3, 154');

#SELECIONANDO OS CLIENTES
SELECT * FROM cli_clientes;

#fazendo busca fonetica USANDO A FUNÇÃO SOUNDEX
SELECT * FROM cli_clientes
WHERE SOUNDEX(CLI_NOME) = SOUNDEX('MARCOS');

#CALCULANDO A IDADE DO CLIENTE
SELECT cli_nome, cli_data_nascimento, YEAR(NOW()) - YEAR(cli_data_nascimento) AS IDADE
FROM cli_clientes;
#OU
SELECT cli_nome, cli_data_nascimento, TIMESTAMPDIFF(YEAR, cli_data_nascimento, CURDATE()) AS IDADE
FROM cli_clientes;