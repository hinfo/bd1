/**
Scripts para criar as tabelas do banco
    
*/CREATE TABLE CIDADE (
    ID_CID integer NOT NULL PRIMARY KEY,
    NOME VARCHAR(100),
    PAIS VARCHAR(80),
    ESTADO VARCHAR(80)
);

CREATE TABLE SALA (
    ID_SAL INTEGER NOT NULL PRIMARY KEY,
    DESCRICAO VARCHAR(100),
    CAPACIDADE INTEGER,
    NUMERO INTEGER
);

CREATE TABLE GENERO (
    ID_GEN INTEGER NOT NULL PRIMARY KEY,
    NOME VARCHAR(100)
);

CREATE TABLE FUNCIONARIO(
    ID_FUN INTEGER NOT NULL PRIMARY KEY,
    CPF VARCHAR(11),
    CARGO VARCHAR(50),
    NOME VARCHAR(150),
    RG VARCHAR(10)
);

CREATE TABLE BAIRRO(
    ID_BAR INTEGER NOT NULL PRIMARY KEY,
    NOME VARCHAR(50),
    ID_CID INTEGER,
    FOREIGN KEY (ID_CID) REFERENCES CIDADE(ID_CID)
    ON UPDATE CASCADE ON DELETE SET NULL
);

CREATE TABLE ENDERECO(
    ID_END INTEGER NOT NULL PRIMARY KEY,
    ID_BAR INTEGER,
    ID_FUN INTEGER,
    CEP VARCHAR(10),
    NUMERO INTEGER,
    TIPOLOG VARCHAR(80),
    LOGRADOURO VARCHAR(100),
    COMPLEMENTO VARCHAR(200),
    FOREIGN KEY (ID_BAR) REFERENCES BAIRRO(ID_BAR) ON UPDATE CASCADE ON DELETE SET NULL,
    FOREIGN KEY (ID_FUN) REFERENCES FUNCIONARIO(ID_FUN) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE TELEFONE (
    ID_TEL INTEGER NOT NULL PRIMARY KEY,
    ID_FUN INTEGER,
    DESCRICAO VARCHAR(80),
    RAMAL INTEGER,
    NUMERO VARCHAR(13),
    COD_AREA INTEGER,
    FOREIGN KEY (ID_FUN) REFERENCES FUNCIONARIO(ID_FUN) ON UPDATE CASCADE ON DELETE CASCADE
 
);

CREATE TABLE FILME (
    ID_FIL INTEGER NOT NULL PRIMARY KEY,
    ID_GEN INTEGER,
    DESCRICAO VARCHAR(100),
    DATA_EXIBICAO DATE,
    VALOR NUMERIC(15,2),
    NOME VARCHAR(110),
    FOREIGN KEY (ID_GEN) REFERENCES GENERO(ID_GEN) ON UPDATE CASCADE ON DELETE SET NULL
);

CREATE TABLE SESSAO(
    ID_SES INTEGER NOT NULL PRIMARY KEY,
    ID_SAL INTEGER,
    ID_FIL INTEGER,
    OBS VARCHAR(100),
    ESPECTADORES INTEGER,
    HORARIO TIME,
    FOREIGN KEY (ID_SAL) REFERENCES SALA(ID_SAL) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (ID_FIL) REFERENCES FILME(ID_FIL) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE VENDA(
    ID_VEN INTEGER NOT NULL PRIMARY KEY,
    ID_FUN INTEGER, 
    FORMA_PGTO VARCHAR(20),
    DATA DATE,
    FOREIGN KEY (ID_FUN) REFERENCES FUNCIONARIO(ID_FUN) ON UPDATE CASCADE ON DELETE SET NULL  
);

CREATE TABLE VENDA_FILME(
    ID_VEN INTEGER NOT NULL,
    ID_FIL INTEGER NOT NULL,
    QUANT INTEGER,
    PRECO_UNIT NUMERIC(15,2),
    PRIMARY KEY (ID_VEN,ID_FIL),
    FOREIGN KEY (ID_VEN) REFERENCES VENDA(ID_VEN) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (ID_FIL) REFERENCES FILME(ID_FIL) ON UPDATE CASCADE ON DELETE CASCADE
);

/*
    CREATE GENERATOR
*/
CREATE GENERATOR G_BAIRRO;
CREATE GENERATOR G_CIDADE;
CREATE GENERATOR G_ENDERECO;
CREATE GENERATOR G_FILME;
CREATE GENERATOR G_FUNCIONARIO;
CREATE GENERATOR G_GENERO;
CREATE GENERATOR G_SALA;
CREATE GENERATOR G_SESSAO;
CREATE GENERATOR G_TELEFONE;
CREATE GENERATOR G_VENDA;


/*
    CREATE TRIGGER
*/

CREATE trigger T_BAIRRO FOR bairro
ACTIVE BEFORE INSERT POSITION 5
AS
BEGIN
NEW.ID_BAR=gen_id(g_bairro,1);
END

CREATE trigger T_CIDADE FOR CIDADE
ACTIVE BEFORE INSERT POSITION 5
AS
BEGIN
NEW.ID_CID=GEN_ID(g_cidade,1);
END

CREATE TRIGGER T_ENDERECO FOR endereco
ACTIVE BEFORE INSERT POSITION 5
AS
BEGIN
NEW.ID_END=gen_id(g_endereco,1);
END

CREATE TRIGGER T_FILME FOR FILME
ACTIVE BEFORE INSERT position 5
AS
BEGIN
NEW.ID_FIL=gen_id(g_filme,1);
END

CREATE TRIGGER T_FUNCIONARIO FOR FUNCIONARIO
ACTIVE BEFORE INSERT position 5
AS
BEGIN
NEW.ID_FUN=GEN_ID(g_funcionario,1);
end

CREATE TRIGGER T_GENERO FOR GENERO
ACTIVE BEFORE INSERT POSITION 5
AS
BEGIN
NEW.ID_GEN=GEN_ID(g_genero,1);
END

CREATE TRIGGER T_SALA FOR SALA
ACTIVE BEFORE INSERT POSITION 5
AS
BEGIN
NEW.ID_SAL=GEN_ID(g_sala, 1);
END

CREATE TRIGGER T_SESSAO FOR SESSAO
ACTIVE BEFORE INSERT position 5
AS
BEGIN
NEW.ID_SES=GEN_ID(g_sessao,1);
END

CREATE TRIGGER T_TELEFONE FOR telefone
ACTIVE BEFORE INSERT POSITION 5
AS
BEGIN
NEW.ID_TEL=GEN_ID(G_TELEFONE,1);
END

CREATE TRIGGER T_VENDA FOR VENDA
ACTIVE BEFORE INSERT POSITION 5
AS
BEGIN
NEW.ID_VEN=gen_id(G_VENDA,1);
END

--Select com expressões
SELECT r.QUANT, r.PRECO_UNIT,(r.QUANT*r.PRECO_UNIT)
FROM VENDA_FILME r

SELECT r.ID_VENDA, r.PRECO_UNIT, r.QUANT, (r.PRECO_UNIT*r.QUANT) 
as receita,r.QUANT*12 as total_anual
FROM VENDA_FILME r

SELECT r.ID_SALA, r.DESCRICAO, r.CAPACIDADE, (r.CAPACIDADE/2) 
as capacidade_parcial
FROM SALA r

