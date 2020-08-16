#Criando uma tabela
CREATE DATABASE nome_database;

#Ou
CREATE SCHEMA nome_schema;

#Para excluir um banco de dados, 
#podemos utilizar o comando DROP. Veja sua sintaxe
DROP DATABASE nome_database;

#Ou
DROP SCHEMA nome_schema;

#IDENTIFICAR UM BANCO
SELECT DATABASE();

#Criando tabelas no MySQL
CREATE [TEMPORARY] TABLE nome_tabela
(
    nome_coluna tipo [Restrições],
    nome_coluna tipo [Restrições],
    ...
);

CREATE TABLE cli_clientes
(
		#TIPO SERIAL = BIGINT, NOT NULL, AUTO_INCREMENT, UNSIGNED E UNIQUE
		cli_id SERIAL PRIMARY KEY,
        cli_nome VARCHAR(50) NOT NULL,
        cli_data_nascimento DATE,
        cli_logradoura VARCHAR(200)
);

#Restrição com not null
CREATE TABLE produtos (
  codigo integer NOT NULL,
  nome       text    NOT NULL,
  preco      numeric
);

#Restrição UNIQUE
CREATE TABLE produtos (
  codigo integer UNIQUE,
  nome       text,
  preco      numeric
);
#Acima, a restrição está sendo definida como restrição de coluna. Mas é possível defini-la como restrição de tabela
CREATE TABLE produtos (
  codigo integer,
  nome       text,
  preco      numeric,
  UNIQUE (codigo)
);
#A vantagem da definição com restrição de tabela é que, com ela, é possível atribuir um nome à restrição de unicidade
CREATE TABLE produtos (
  codigo integer,
  nome       text,
  preco      numeric,
  CONSTRAINT nome_da_restricao UNIQUE(codigo)
);
#Outra vantagem é que é possível definir um grupo de colunas
CREATE TABLE exemplo (
  a integer,
  b integer,
  c integer,
  UNIQUE (a, c)
);

#cláusula DEFAULT
CREATE TABLE conta (
  numero int UNIQUE,
  agencia int NOT NULL,
  saldo float NOT NULL DEFAULT 0,
  limite float NOT NULL DEFAULT 500.00,
  cartao varchar(3) NOT NULL DEFAULT 'Não'
);

#Chaves primárias
#Veja um exemplo da definição deste campo na tabela abaixo
CREATE TABLE produtos (
  id_produto integer PRIMARY KEY,
  nome       text,
  preco      numeric
);

#Em termos práticos, a restrição de chave primária 
#é uma junção das restrições NOT NULL e UNIQUE. A tabela abaixo aceita os mesmos dados que a anterior:
CREATE TABLE produtos (
  id_produto integer UNIQUE NOT NULL,
  nome       text,
  preco      numeric
);

#Também é possível definir a chave primária como uma restrição de tabela. 
#Assim, é possível mais de uma coluna como chave primária
CREATE TABLE exemplo (
  a integer,
  b integer,
  c integer,
  PRIMARY KEY (a, c)
);

#Nesta situação, também é possível nomear a restrição
CREATE TABLE exemplo (
  a integer,
  b integer,
  c integer,

  CONSTRAINT nome_da_chave PRIMARY KEY (a, c)
);

#Chaves estrangeiras
#Para codificar esta situação no banco, podemos supor a tabela produtos com a estrutura abaixo
CREATE TABLE produtos (
  id_produto integer PRIMARY KEY,
  nome       varchar(100),
  preco      numeric
);
#Para definir uma restrição de chave estrangeira, na tabela pedidos, utilizamos uma restrição de tabela com a sintaxe abaixo
FOREIGN KEY (campo_da_tabela_que_fara_referencia) REFERENCES tabela_referencia(campo_da_tabela_referenciada);
#Com isso, a tabela pedidos pode ter a estrutura abaixo
CREATE TABLE pedidos (
    id_pedido integer PRIMARY KEY,
    id_produto integer,
    quantidade integer,
    FOREIGN KEY (id_produto) REFERENCES produtos(id_produto)
);

/*
Fazendo um teste com comentários em blocos.
*/

#Inserindo dados
#A primeira sintaxe é a mesma utilizada por todos os bancos de dados:
INSERT [INTO] nome_tabela (nome_coluna1, ...) VALUES (valor 1, ...);

/*
Obs: Veja que na sintaxe, o comando into pode ser omitido, mas a sugestão é sempre colocá-lo.

Também é possível declarar os campos apenas uma vez e inserir várias linhas de uma vez. A sintaxe é a seguinte:
*/
INSERT [INTO] nome_tabela (nome_coluna1, ...) VALUES (valor linha 1, ...), (valor linha 2, ...);

#E no MySQL também ainda existe um outro comando para inserir dados na tabela, que é diferente do padrão SQL, e cuja sintaxe é:
INSERT INTO nome_tabela
SET nome_coluna1 = valor1,
  nome_coluna2 = valor2,
  ...
  nome_colunaN = valorN;
  
  #Exibindo os dados de uma tabela
  #Sua sintaxe básica é
  SELECT coluna1,coluna2,coluna3,... colunaN FROM nome_tabela [WHERE condição];
  
  #Operadores de comparação
SELECT * FROM carro WHERE modelo = 'Celta';
#Ou de diferença, se quisermos obter o resultado inverso da consulta acima:
SELECT * FROM carro WHERE modelo <> 'Celta';

#Alterando dados
#Para alterar os dados em uma tabela, podemos utilizar o comando UPDATE. Veja a sintaxe:
UPDATE nome_tabela
SET nome_coluna1= novo_valor1,
    nome_coluna2 =  novo_valor2,
    ...
    nome_colunaN = novo_valorN
[WHERE condição];

#Excluindo dados
#O comando que permite excluir tuplas de uma tabela é o DELETE. A sintaxe básica desse comando é:
DELETE FROM nome_tabela [WHERE condição];

#Aliases
#Esses nomes diferentes são chamados de “alias” ("apelido") e são gerados usando a palavra-chave AS no enunciado que faz a consulta. Por exemplo:
SELECT CodFor AS 'Código do Fornecedor', RazSoc AS 'Razão Social' FROM Fornecedores;

#A cláusula DISTINCT
#O DISTINCT deve ser informado após o SELECT, não importando quantas colunas forem definidas na consulta:
SELECT DISTINCT rua, cidade FROM fornecedores;

#Ordenação de registros com a cláusula ORDER BY
#A cláusula ORDER BY é usada para ordenar os valores do resultado de uma consulta. Ela deve ser colocada no final do comando. Sua sintaxe é:
ORDER BY critério_de_classificação [ASC | DESC];
SELECT DISTINCT estado, cidade FROM Fornecedores
ORDER BY estado;
#Caso fosse necessário ordenar de modo decrescente, o DESC deveria ser especificado:
SELECT DISTINCT estado, cidade FROM fornecedores
ORDER BY estado DESC;
#A cláusula ORDER BY pode se referir a mais de uma coluna da tabela de origem. Para isso, basta separá-las por vírgula:
SELECT * FROM tabela ORDER BY coluna1, coluna2 ... colunaN;

#Explorando a cláusula WHERE
#Operador AND
SELECT * FROM carro WHERE cod = 1 AND placa = 'asd0989';
#Operador OR
SELECT * FROM aluno WHERE nome = 'wagner' OR cod = 5;
#Operador NOT
SELECT * FROM carro WHERE NOT cod = 2;
#Condições IS NULL e IS NOT NULL
SELECT * FROM fornecedores
WHERE CEP = NULL;
SELECT * FROM fornecedores
WHERE CEP IS NULL;
SELECT * FROM fornecedores
WHERE CEP IS NOT NULL;
#Operador BETWEEN
SELECT * FROM tabela WHERE campo BETWEEN valor_inicial AND valor_final;
SELECT * FROM fornecedores WHERE codigo BETWEEN 3 and 7;
#Operador IN
SELECT * FROM fornecedores WHERE codigo IN (1, 5, 9);
SELECT * FROM tabela WHERE campo IN (SELECT campo FROM tabela2);
#Operador LIKE
/*
O operador LIKE é outro operador que pode ser utilizado com o comando WHERE. 
Porém, diferente dos operadores que vimos anteriormente, este só pode ser utilizado em cadeias de caracteres(string).
*/
#Operador REGEXP ou RLIKE
/*
O REGEXP é parecido com o LIKE. Ele só pode ser utilizado em cadeias de caracteres(string) e 
verifica se a cadeia de caracteres corresponde ao padrão especificado. 
Este operador também possui um operador sinônimo que é o RLIKE. Ambos são equivalentes.
*/

#ADICIONANDO A COLUNA 
ALTER TABLE cli_clientes
ADD cli_cpf CHAR(14) NOT NULL;

#ADICIONANDO UMA COLUNA COM VALOR PADRÃO E SELECIONANDO A POSIÇÃO
ALTER TABLE cli_clientes
ADD cli_cpf CHAR(14) NOT NULL DEFAULT '-' AFTER cli_nome;

#REMOVENDO A COLUNA 
ALTER TABLE cli_clientes
DROP COLUMN cli_cpf;

#ALTERANDO A TABELA PARA UMA CONSTRAINT NO CPF 
#obs. se o campo tiver duplicado, não irá funcionar
ALTER TABLE cli_clientes
ADD CONSTRAINT UN_CLI_CLIENTES__CLI_CPF UNIQUE(cli_cpf); 

#ALTERANDO NOME DE COLUNA
ALTER TABLE nome_da_tabela
CHANGE nome_atual novo_nome [Tipo de Dados];

#fazendo busca fonetica USANDO A FUNÇÃO SOUNDEX
SELECT * FROM cli_clientes
WHERE SOUNDEX(CLI_NOME) = SOUNDEX('MARCOS');

#CALCULANDO A IDADE DO CLIENTE
SELECT cli_nome, cli_data_nascimento, YEAR(NOW()) - YEAR(cli_data_nascimento) AS IDADE
FROM cli_clientes;
#OU
SELECT cli_nome, cli_data_nascimento, TIMESTAMPDIFF(YEAR, cli_data_nascimento, CURDATE()) AS IDADE
FROM cli_clientes;

#INNER JOINS
#USANDO A FORMA ANTIGA
SELECT tab1.coluna1, tab1.coluna2, ..., tab1.colunaN, tab2.coluna1, tab2.coluna2, ..., tab2.colunaN
FROM tabela1 tab1, tabela2 tab2
WHERE tab1.codtab1 = tab2.codtab1;

#A sintaxe para realizar uma consulta usando o INNER JOIN é a seguinte:
SELECT * FROM tabela1 apelido1
  INNER JOIN tabela2 apelido2
  ON (apelido1.campo1 = apelido2.campo2);
  
  #A sintaxe do LEFT JOIN no SQL é a seguinte:
SELECT * FROM tabela_da_esquerda apelido
LEFT JOIN tabela_da_direita apelido
ON (condição);

#Veja a sintaxe do RIGHT JOIN:
SELECT * FROM tabela_da_esquerda apelido
  RIGHT JOIN tabela_da_direita apelido
  ON (condição);
  
#GROUP BY
SELECT estado, COUNT(*) as 'Fornecedores' FROM fornecedores GROUP BY estado;

#HAVING
SELECT cod_cliente, COUNT(*) as 'Fornecedores' FROM fornecedores GROUP BY cod_cliente HAVING COUNT(cod_fornecedor) > 5;

#APAGANDO LINHA DA TABELA
DELETE FROM [NOME DA TABELA] WHERE [NOME DO CAMPO] = [VALOR DO CAMPO];

#ADICIONANDO CHAVE ESTRAGEIRA
ALTER TABLE prd_produtos
ADD CONSTRAINT fk_prd_produtos__unm_unidade_medidas__unm_id FOREIGN KEY(unm_id) REFERENCES unm_unidade_medidas (unm_id);

#ALTERANDO O TIPO DA COLUNA
ALTER TABLE [NOME DA TABELA]
CHANGE COLUMN [NOME ATUAL DO CAMPO] [NOVO NOME] [TIPO DO DADO] [SE SERÁ POSITIVO] [ACEITA NULO];
#EXEMPLO
ALTER TABLE prd_produtos
CHANGE COLUMN unm_id unm_id BIGINT UNSIGNED NOT NULL;

#Criando Views
#Para definir views em um banco de dados, utilize a declaração CREATE VIEW, que tem a seguinte sintaxe:
CREATE [OR REPLACE] [ALGORITHM = algorithm_type] VIEW view_name [(column_list)]
AS select_statement [WITH [CASCADED | LOCAL] CHECK OPTION]

#Views atualizáveis
#Atribuir esta opção, na criação de uma View, significa que atualizações emitidas terão que se encaixar às 
#condições definidas na cláusula WHERE da consulta SELECT. Por exemplo:
CREATE VIEW v_maiorestoque AS SELECT id_produto, quantidade
FROM estoque WHERE quantidade >= 100 WITH CHECK OPTION;

#User functions
#Para criarmos uma user function, utilizarmos o comando abaixo:
CREATE FUNCTION nome ([parâmetros[...]])
    RETURNS tipo
    Instruções da função
    
#cláusula DELIMITER
DELIMITER $$
CREATE FUNCTION nome ([parâmetros[...]])
    RETURNS tipo
    Instruções da função
$$
DELIMITER ;

#Variáveis
DECLARE nome_variavel tipo_dado

#Para atribuir um valor para a variável, pode se utilizar a cláusula SET:
SET nome_variavel = valor

#Para criar essa função você tem que habilitar uma configuração, basta executar o comando abaixo:
SET GLOBAL log_bin_trust_function_creators = 1;

#stored procedures
#A sintaxe geral para a criação de uma stored procedure, é:
CREATE PROCEDURE proc_name([parameters, ...])[characteristics]
[BEGIN]
  corpo_da_rotina;
[END]

#Cursores
#Para criá-los, deve-se utilizar a cláusula DECLARE CURSOR, que possui a sintaxe:
DECLARE nome_cursor CURSOR
     FOR comando_select

#Após a declaração do cursor, para ele ser percorrido, é necessário abri-lo com a cláusula OPEN:
OPEN nome_cursor

#Ao final do seu uso, é importante fechá-lo com a cláusula CLOSE:
CLOSE nome_cursor

#Após o cursor ser aberto, é possível manipular suas linhas com o comando FETCH, que possui a sintaxe:
FETCH [[NEXT] FROM] nome_cursor;

#cláusula INTO:
FETCH [[NEXT] FROM] nome_cursor INTO @nome_variavel_1, @nome_variavel_2, etc;

#BEGIN, COMMIT e ROLLBACK
START TRANSACTION
BEGIN [WORK]
--instruções
COMMIT [WORK]
ROLLBACK [WORK]

#MOSTRANDO O ULTIMO ID GERADO
SELECT LAST_INSERT_ID();

#triggers
CREATE [DEFINER = { user | CURRENT_USER }]
TRIGGER trigger_name trigger_time trigger_event
ON tbl_name FOR EACH ROW trigger_stmt