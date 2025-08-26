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

INSERT INTO clientes (nome , email , cidade) VALUES
('Leonardo Camargos', 'leocamargos@hotmail.com', 'Uberlandia'),
('Joao Vitor', 'joaovitor@hotmail.com', 'Uberlandia'),
('Rosa Maria', 'rosamaria@hotmail.com', 'Franca'),
('Cintia Camargos', 'lbcopias@hotmail.com', 'Catalao'),
('Henrique Lemos', 'henriquelemos@hotmail.com', 'Araguari');


INSERT INTO pedidos (id_cliente , valor_total) VALUES 
(1 , 5500.00),
(2 , 2000.00);

INSERT INTO itens_pedido (id_pedido , id_produto , quantidade , preco_unitario) VALUES 
(1,1,1,3500),
(1,2,1,2500),
(2,2,1,2000);

#Resumindo o que essa query faz:
#Ela retorna uma lista com o nome do cliente e o valor total de cada pedido que ele fez.
#Se um cliente tiver 3 pedidos, ele aparecerá 3 vezes (um por pedido).
#Clientes que não possuem pedidos não aparecem no resultado (porque é INNER JOIN
SELECT 
    clientes.nome,
    pedidos.valor_total
FROM
    clientes
    INNER JOIN pedidos ON clientes.id = pedidos.id_cliente;

#CONCEITO DE SUBQYERY - PLUS
#Em resumo, a subquery funciona como um filtro dinâmico: em vez de você escrever WHERE id_marca = 3, você deixa o SQL descobrir qual é esse ID dentro de outra tabela.

SELECT 
    nome,preco
FROM
    produtos
WHERE 
    id_marca IN (SELECT id FROM marcas WHERE nome = 'Lucas Abreu')

#usando inner join para o exemplo acima
SELECT 
    produtos.nome,  
    produtos.preco
FROM 
    produtos
INNER JOIN marcas ON produtos.id_marca = marcas.id
WHERE 
    marcas.nome = 'Lucas Abreu' ;



/*
Desafio 1: Listar o nome da marca e o nome dos produtos de todas as marcas que começam com 'L'
- Usa INNER JOIN entre produtos e marcas
- Usa LIKE 'L%' para filtrar marcas que começam com 'L'
- Resultado esperado: todas as marcas e produtos cujas marcas começam com 'L'

Desafio 2: Listar apenas os produtos da marca "Leonardo Camargos" com preço acima de 200
- Pode ser feito com INNER JOIN ou SUBQUERY
- Filtra pelo nome da marca e pelo preço do produto
- Resultado esperado: produtos da marca "Leonardo Camargos" com valor > 200

Desafio 3: Mostrar o nome das marcas e a quantidade de produtos de cada marca
- Usa INNER JOIN entre produtos e marcas
- Usa GROUP BY no nome da marca
- Usa COUNT(*) para contar produtos por marca
- Resultado esperado: uma linha por marca mostrando quantos produtos cada uma possui
*/


SELECT 
    marcas.nome,
    produtos.nome
FROM 
    produtos
INNER JOIN marcas ON produtos.id_marca = marcas.id
WHERE 
     marcas.nome LIKE 'l%';


SELECT 
    produtos.nome,  
    produtos.preco
FROM 
    produtos
INNER JOIN marcas ON produtos.id_marca = marcas.id
WHERE 
    marcas.nome = 'Leonardo Camargos' AND
    produtos.preco > 200;


SELECT 
    marcas.nome AS marcas , COUNT(*) AS estoque
FROM 
    produtos
INNER JOIN marcas ON produtos.id_marca = marcas.id
GROUP BY marcas.nome;  


SELECT * FROM marcas
