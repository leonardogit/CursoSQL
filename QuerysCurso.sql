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
('Iphone 12 Pro max' , 8500 , 14 , 2);

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


SELECT * FROM produtos WHERE estoque < 80

SELECT * FROM produtos where estoque < 80  AND preco > 3000;

SELECT * FROM produtos WHERE nome LIKE 'Iphone%'
ORDER BY preco DESC 

# inner join -  retorna apenas as linhas aonde á correspondecia entre as tabelas envolvidas ou seja deve existir em ambas tabelas
# full join  -  retorna todas as linhas de ambas as tabelas nao importando se ha correspondencia , no caso as linhas que nao terao correspondecia terao serao preenchidas com null
# left join  -  retorna todas as linhas da tabela a esquerda ou seja aquela esquerda ou seja a primeira tabela mencionada no join e as linhas correspondendes da tabela a direita(caso nao ouver correspondencia virao como null)
# right join -  retorna todas as linhas da tabela a direita ou seja aquela segunda do join e as linhas correspondendes da tabela a esquerda (caso ouver null será devolvido null)
# mais comum no dia a dia é o left join (alguns Bancos nao suportam right join)


# CREATE TABLE CLIENTS

CREATE TABLE clientes (
    id INTEGER PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR (100),
    email VARCHAR (150),
    cidade VARCHAR (50),
    data_nascimento DATE
)

SELECT * FROM clientes

# CREATE TABLE Orders

CREATE TABLE pedidos (
    id INTEGER PRIMARY KEY AUTO_INCREMENT,
    data_pedido DATE DEFAULT (NOW()) ,
    id_cliente INTEGER,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id) ,
    valor_total REAL
)

#CREATE TABLE ORDERS ITENS

CREATE TABLE itens_pedido (
    id_pedido INTEGER ,
    id_produto INTEGER,
    quantidade INTEGER,
    preco_unitario REAL ,
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id),
    FOREIGN KEY (id_produto) REFERENCES produtos(id),
    PRIMARY KEY (id_pedido , id_produto)
)

DROP TABLE cliente