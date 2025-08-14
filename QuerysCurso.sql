CREATE TABLE marcas (
    id INTEGER PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR (150) NOT NULL UNIQUE,
    site VARCHAR (100),
    telefone VARCHAR (15)
);

CREATE TABLE produtos (
    id INTEGER PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR (15) NOT NULL,
    preco REAL,
    estoque INTEGER DEFAULT 0
);

ALTER TABLE produtos
ADD CONSTRAINT fk_produtos_marcas
FOREIGN KEY (id_marca)
REFERENCES marcas(id);

INSERT INTO marcas (
    nome ,
    site ,
    telefone
)
VALUES 
('Leonardo Camargos', 'leocamargos.com', '34998730005'),
('Lucas Abreu', 'lucas.com', '34998730005');

INSERT INTO produtos 
(nome , preco , estoque , id_marca)
VALUES 
('Iphone 12 Pro max' , 4500.22 , 14 , 2);

Alter TABLE produtos
MODIFY nome VARCHAR(100);

SELECT * from produtos

SELECT id , nome FROM produtos;

SELECT preco FROM produtos WHERE preco = 4500.22;

#Trabalhando com insert com select

CREATE TABLE produtos_genericos (
    nome VARCHAR (150),
    estoque INTEGER DEFAULT 0
);

INSERT INTO produtos_genericos 
SELECT nome , estoque FROM produtos WHERE nome = 'Iphone';

SELECT * FROM produtos_genericos

#Limpando tabela
TRUNCATE TABLE produtos_genericos

#Exlcuindo tabela
DROP TABLE produtos_genericos;

#atualizando dados

UPDATE produtos_genericos 
SET nome = 'Iphone 12 Pro Max'
WHERE nome = 'Iphone'

#Update sem where cuidado
UPDATE produtos 
SET estoque = estoque + 10 
WHERE id_marca = 2;