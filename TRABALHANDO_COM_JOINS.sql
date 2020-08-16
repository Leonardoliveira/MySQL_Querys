#SELECIONANDO O BANCO
USE tw_nfe;

#CRIANDO UMA TABELA DE PRODUTOS
CREATE TABLE prd_produtos(
	prd_id SERIAL PRIMARY KEY, 
    prd_nome VARCHAR(30) NOT NULL,
    prd_codigo VARCHAR(50) DEFAULT '-'
);

#SELECIONANDO A TABELA
SELECT * FROM prd_produtos;

#CRIANDO TABELA PARA UNIDADE DE MEDIDAS
CREATE TABLE unm_unidade_medidas (
	unm_id SERIAL PRIMARY KEY,
    unm_nome VARCHAR(30),
    unm_sigla VARCHAR(5) NOT NULL
);

#SELECIONANDO A TABELA
SELECT * FROM unm_unidade_medidas;

#ADICIONANDO UMA COLUNA PARA RECEBER A CHAVE ESTRANGEIRA
ALTER TABLE prd_produtos
ADD COLUMN unm_id INT NOT NULL;

#INSERINDO VALORES NA TABELA 
INSERT INTO unm_unidade_medidas (unm_nome, unm_sigla) VALUES
('Quiligrama', 'Kg');

#INSERINDO UM NOVO PRODUTO
INSERT INTO prd_produtos (prd_nome, prd_codigo, unm_id) VALUES
('Carne', '1234', 1);

#ADICIONANDO CHAVE ESTRAGEIRA
ALTER TABLE prd_produtos
ADD CONSTRAINT fk_prd_produtos__unm_unidade_medidas__unm_id 
FOREIGN KEY(unm_id) REFERENCES unm_unidade_medidas (unm_id);

#ALTERANDO O TIPO DA COLUNA
ALTER TABLE prd_produtos
CHANGE COLUMN unm_id unm_id BIGINT UNSIGNED NOT NULL;

#INSERINDO NOVOS VALORES NA TABELA 
INSERT INTO unm_unidade_medidas (unm_nome, unm_sigla) VALUES
('Pacote', 'Pc');

#SELECIONANDO A TABELA
SELECT * FROM unm_unidade_medidas;

#INSERINDO UM NOVO PRODUTO
INSERT INTO prd_produtos (prd_nome, prd_codigo, unm_id) VALUES
('Bolacha', '3456A', 2);

#SELECIONANDO A TABELA
SELECT * FROM prd_produtos;

#CRIANDO UMA TABELA PARA COMPRAS
CREATE TABLE cmp_compras(
	cmp_id SERIAL PRIMARY KEY,
    cmp_data_hora DATETIME NOT NULL DEFAULT NOW(),
    cmp_valor_pago DECIMAL(8,2) NOT NULL,
    cli_id BIGINT UNSIGNED NOT NULL,
    FOREIGN KEY (cli_id) REFERENCES cli_clientes (cli_id)
);

#CRIANDO TABELA DE n PARA n
CREATE TABLE cmp_prd_compras_produtos(
	prd_id BIGINT UNSIGNED NOT NULL,
    cmp_id BIGINT UNSIGNED NOT NULL,
    cmp_prd_quantidade INT NOT NULL,
    cmp_prd_preco DECIMAL(8,2) NOT NULL,
    PRIMARY KEY (prd_id, cmp_id),
    FOREIGN KEY (prd_id) REFERENCES  prd_produtos (prd_id),
    FOREIGN KEY (cmp_id) REFERENCES  cmp_compras (cmp_id)
);


