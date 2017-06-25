/**
Scripts para criar as tabelas do banco
    
*/CREATE TABLE CIDADE (
    ID_CID integer NOT NULL PRIMARY KEY,
    NOME VARCHAR(100),
    PAIS VARCHAR(80),
    ESTADO VARCHAR(80)
);

CREATE TABLE SALA (
    ID_SALA INTEGER NOT NULL PRIMARY KEY,
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
    FOREIGN KEY (ID_BAR) REFERENCES BAIRRO(ID_BAR) ON UPDATE CASCADE ON DELETE SET NULL
    FOREIGN KEY (ID_FUN) REFERENCES FUNCIONARIO(ID_FUN) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE TELEFONE (
    ID_TEL INTEGER NOT NULL PRIMARY KEY,
    ID_FUN INTEGER,
    DESCRICAO VARCHAR(80),
    RAMAL INTEGER,
    NUMERO VARCHAR(13),
    COD_AREA INTEGER(2),
    FOREIGN KEY (ID_FUN) REFERENCES FUNCIONARIO(ID_FUN) ON UPDATE CASCADE ON DELETE SET NULL
 
);

CREATE TABLE FILME (
    ID_FIL INTEGER NOT NULL PRIMARY KEY,
    ID_GEN INTEGER,
    DESCRICAO VARCHAR(100),
    DATA_EXIBICAO DATE,
    VALOR FLOAT,
    NOME VARCHAR(110),
    FOREIGN KEY (ID_GEN) REFERENCES GENERO(ID_GEN) ON UPDATE CASCADE ON DELETE SET NULL
);

CREATE TABLE SESSAO(
    ID_SES INTEGER NOT NULL PRIMARY KEY,
    ID_SAL INTEGER,
    ID_FIL INTEGER,
    OBS VARCHAR(100),
    ESPECTADORES INTEGER,
    HORARIO VARCHAR(10),
    FOREIGN KEY (ID_SAL) REFERENCES SALA(ID_SAL) ON UPDATE CASCADE ON DELETE SET NULL
    FOREIGN KEY (ID_FIL) REFERENCES FILME(ID_FIL) ON UPDATE CASCADE ON DELETE SET NULL
);

CREATE TABLE VENDA(
    ID_VENDA INTEGER NOT NULL PRIMARY KEY,
    ID_FUN INTEGER, 
    FORMA_PGTO VARCHAR(20),
    DATA DATE,
    FOREIGN KEY (ID_FUN) REFERENCES FUNCIONARIO(ID_FUN) ON UPDATE CASCADE ON DELETE SET NULL  
);

CREATE TABLE VENDA_FILME(
    ID_VEN INTEGER NOT NULL,
    ID_FIL INTEGER NOT NULL,
    QUANT INTEGER,
    PRECO_UNIT FLOAT,
    PRIMARY KEY (ID_VEN,ID_FIL),
    FOREIGN KEY (ID_VEN) REFERENCES VENDA(COD_VEN) ON UPDATE CASCADE ON DELETE CASCADE
    FOREIGN KEY (ID_FIL) REFERENCES FILME(COD_FIL) ON UPDATE CASCADE ON DELETE CASCADE
);

