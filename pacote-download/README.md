# Projeto Integrador
### Estoque Inteligente


Nosso principal objetivo é demonstrar o consumo dos medicamentos controlados de uma farmácia. Utilizamos a linguagem SQL por meio do  `RGBD - postgresql` para a realização dos relatórios finais. Para uma demonstração mais visual utilizamos o `Power BI`. E utilizamos a linguagem `Python` para a criação da interface gráfica. Como principal resultado demonstramos tanto em quantidade quanto em real o valor do estoque total e o valor da perda por validade dos medicamentos existentes.


#### Criação das Tabelas:

```
DROP TABLE IF EXISTS cliente CASCADE ;
CREATE TABLE cliente(
	codigo_cliente SMALLINT NOT NULL ,
	cpf CHAR(11) NOT NULL ,
	data_nascimento DATE NOT NULL ,
	telefone NUMERIC(11, 4) ,
	sexo CHAR(1) NOT NULL CHECK ( sexo IN ('M' , 'F') ),
	endereco VARCHAR(40) ,
	PRIMARY KEY (codigo_cliente) )
;

DROP TABLE IF EXISTS pedido CASCADE ;
CREATE TABLE pedido (
	numero_pedido SMALLINT ,
	quantidade_produto SMALLINT , 
	data_pedido DATE NOT NULL ,
	codigo_cliente SMALLINT ,
	tipo_pedido VARCHAR(10) NOT NULL CHECK ( tipo_pedido IN ('COMPRA','DEVOLUÇÃO')) ,
	nota_fiscal_devolucao SMALLINT ,
	codigo_medicamento SMALLINT NOT NULL ,
	PRIMARY KEY (numero_pedido) ,
	FOREIGN KEY (codigo_cliente) REFERENCES cliente
) ;

DROP TABLE IF EXISTS estoque CASCADE ;
CREATE TABLE estoque (
	data_entrada DATE NOT NULL ,
	nota_fiscal_estoque SMALLINT NOT NULL ,
	PRIMARY KEY (data_entrada)
);

DROP TABLE IF EXISTS medicamento CASCADE ;
CREATE TABLE medicamento (
	nome_medicamento VARCHAR(30) NOT NULL ,
	data_validade DATE NOT NULL ,
	data_fabricacao DATE NOT NULL ,
	valor_base SMALLINT NOT NULL ,
	data_entrada DATE NOT NULL,
	quantidade_estoque SMALLINT NOT NULL ,
	preco NUMERIC (6, 2) ,
	classificacao_produto VARCHAR(15) ,
	apresentacao VARCHAR(30) , -- fórmula/quantidade
	tarja VARCHAR(10) ,
	codigo_medicamento SMALLINT NOT NULL ,
	PRIMARY KEY (codigo_medicamento) ,
	FOREIGN KEY (data_entrada) REFERENCES estoque
) ;

DROP TABLE IF EXISTS baixa_estoque CASCADE ;
CREATE TABLE baixa_estoque (
	numero_baixa SMALLINT NOT NULL ,
	data_saida DATE NOT NULL,
	numero_pedido SMALLINT NOT NULL ,
	nota_fiscal_devolucao SMALLINT ,
	nota_fiscal_estoque SMALLINT ,
	data_entrada DATE NOT NULL, 
	codigo_medicamento SMALLINT NOT NULL ,
	PRIMARY KEY (numero_baixa) ,
	FOREIGN KEY (numero_pedido) REFERENCES pedido ,
	FOREIGN KEY (data_entrada) REFERENCES estoque ,
	FOREIGN KEY (codigo_medicamento) REFERENCES medicamento
) ;

```

Fora adicionados 100 clientes assim como 40 medicamentos.


#### SELECTS:

```
-- Quantidade de medicamentos no estoque, por nome.

SELECT quantidade_estoque AS "Quantidade em Estoque", nome_medicamento AS "Medicamento"
FROM medicamento
GROUP BY quantidade_estoque, nome_medicamento ;


-- Agrupando os medicamentos por tipo de tarja.

SELECT tarja AS "Tipo de Tarja", COUNT(tarja) AS "Quantidade por Tarja"
FROM medicamento
GROUP BY (tarja); 

-- Agrupando medicamentos por tarja, diferenciando os produtos.

SELECT nome_medicamento AS medicamento, valor_base AS VB
FROM medicamento
WHERE UPPER(tarja)='PRETA';

SELECT nome_medicamento AS medicamento, valor_base AS VB
FROM medicamento
WHERE UPPER(tarja)='VERMELHA';

-- Valor em R$ do estoque.

SELECT classificacao_produto AS "Classificação Medicamento", SUM(preco) AS "Valor em Real em Estoque"
FROM medicamento
GROUP BY classificacao_produto ;

-- Medicamentos em estoque vencidos ou com validade < que 30 dias 

SELECT TO_CHAR(data_validade, 'MM/YYYY') AS "Validade Medicamento", codigo_medicamento AS "SKU", nome_medicamento AS "Medicamento" /** SUM(preco) **/
FROM medicamento
WHERE data_validade <= current_date - INTERVAL '30' DAY ;

-- Perdas (totais) em R$ dos medicamentos que irão vencer nos próximos 30 dias

SELECT SUM(preco) AS "Valor"
FROM medicamento
WHERE data_validade <= current_date - INTERVAL '30' DAY ;

-- Perdas (por medicamento) em R$ dos medicamentos que irão vencer nos próximos 180 dias.

SELECT TO_CHAR(data_validade, 'MM/YYYY') AS "Validade Medicamento", codigo_medicamento AS "SKU", nome_medicamento AS "Medicamento", 
		SUM(preco) "Perdas em Reais"
FROM medicamento
WHERE data_validade <= current_date - INTERVAL '30' DAY
GROUP BY data_validade, codigo_medicamento ;

-- Medicamentos em excesso (valor base: valor de cada produto estipulado para o perfil da loja)

SELECT valor_base AS "Valor Base", quantidade_estoque AS "Quantidade em Estoque ", nome_medicamento AS "Nome do medicamento"
FROM medicamento 
WHERE valor_base < quantidade_estoque ;

-- Medicamentos em estoque que não foram vendidos (para análise e melhora da rotatividade de produtos no estoque)

SELECT nome_medicamento AS "Medicamento", quantidade_estoque AS "Quantidade em Estoque", data_pedido AS "Data do pedido", tipo_pedido AS "Tipo"
FROM medicamento md LEFT OUTER JOIN pedido pd
ON(md.quantidade_estoque = pd.quantidade_produto)
GROUP BY nome_medicamento, quantidade_estoque, quantidade_produto, data_pedido, tipo_pedido ;



```
