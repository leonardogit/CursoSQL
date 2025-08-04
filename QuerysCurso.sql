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
     