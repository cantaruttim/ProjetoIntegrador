SET DATESTYLE TO POSTGRES, DMY ;

-- TABELAS

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

-- Populando tabela cliente (100 clientes)

INSERT INTO cliente VALUES (1, 43422984810, '20/05/1974', 1199265.0099, 'F', 'Rua das Rosas 123') ;
INSERT INTO cliente VALUES (2, 60945641893, '25/01/1980', 1198795.0199, 'M', 'Rua das Tulipas 122') ;
INSERT INTO cliente VALUES (3, 05273196868, '30/11/1972', 1196585.0299, 'F', 'Rua das Pedras 11') ;
INSERT INTO cliente VALUES (4, 49716838875, '12/11/1964', 1199831.7892, 'F', 'Avenida Vergueiro 8000') ;
INSERT INTO cliente VALUES (5, 06948194842, '01/06/1985', 1193265.0749, 'F', 'Avenida Liberdade 2560') ;
INSERT INTO cliente VALUES (6, 49716838875, '22/06/1976', 1197581.0009, 'F', 'Rua Pedro de Albuquerque 45') ;
INSERT INTO cliente VALUES (7, 32236597819, '31/03/1957', 1198338.0447, 'M', 'Avenida Nazaaré 4750') ;
INSERT INTO cliente VALUES (8, 70866191836, '25/04/1992', 1193065.7409, 'F', 'Rua do Sabiá 200') ;
INSERT INTO cliente VALUES (9, 58767692826, '03/09/2003', 1198304.0009, 'F', 'Rua Potenji 451') ;
INSERT INTO cliente VALUES (10, 20287176886, '08/08/1994', 1199760.1459, 'F', 'Rua do Glicério 20') ;
INSERT INTO cliente VALUES (11, 41390280845, '17/01/1996', 1199094.7897, 'F', 'Avenida Sapopemba 1222') ;
INSERT INTO cliente VALUES (12, 59348431846, '04/09/1989', 1193265.1029, 'M', 'Rua Esmeralda 1500') ;
INSERT INTO cliente VALUES (13, 29245363830, '15/03/2001', 1193878.1029, 'M', 'Rua Formosa 789') ;
INSERT INTO cliente VALUES (14, 88837802803, '05/05/1983', 1197455.1029, 'M', 'Avenida Paraíso 100') ;
INSERT INTO cliente VALUES (15, 83688913884, '24/04/1936', 1193168.1029, 'F', 'Rua das Primaveras 785') ;
INSERT INTO cliente VALUES (16, 90260282880, '24/04/1936', 1193558.1029, 'M', 'Rua Maria Luísa Penteado 589') ;
INSERT INTO cliente VALUES (17, 56492877837, '18/08/1981', 1193265.1029, 'F', 'Rua Frederico Moura 2656') ;
INSERT INTO cliente VALUES (18, 76397977803, '16/08/1983', 1193265.1029, 'F', 'Rodovia Raposo Tavares 780') ;
INSERT INTO cliente VALUES (19, 35149964824, '19/11/1969', 1193265.1029, 'F', 'Rua Arlindo Nogueira 467') ;
INSERT INTO cliente VALUES (20, 33627857860, '06/12/1990', 1193265.1029, 'M', 'Travessa Antônio Ferreira 1390') ;
INSERT INTO cliente VALUES (21, 67430785816, '29/05/1982', 1198422.5320, 'F', 'Avenida Afonso Pena 587') ;
INSERT INTO cliente VALUES (22, 47699767802, '03/06/1968', 1195557.9265, 'F', 'Avenida Desembargador Moreira 875') ;
INSERT INTO cliente VALUES (23, 96055552809, '06/12/2003', 1190237.8361, 'F', 'Avenida Esbertalina Barbosa Damiani 2510') ;
INSERT INTO cliente VALUES (24, 76396105837, '13/08/1972', 1196467.5882, 'M', 'Rua dos Carijós 548') ;
INSERT INTO cliente VALUES (25, 91867164841, '24/11/1983', 1191671.5882, 'M', 'Avenida Almirante Maximiano Fonseca 199') ;
INSERT INTO cliente VALUES (26, 10650335830, '13/03/1976', 1193176.7376, 'M', 'Rua das Fiandeiras 471') ;
INSERT INTO cliente VALUES (27, 33912111804, '13/01/1960', 1195328.8556, 'M', 'Rua Arlindo Nogueira 87') ;
INSERT INTO cliente VALUES (28, 05701572854, '02/05/1979', 1196260.1815, 'M', 'Avenida São João 2514') ;
INSERT INTO cliente VALUES (29, 57208815810, '09/11/1957', 1199855.3785, 'M', 'Rua Serra de Bragança 55') ;
INSERT INTO cliente VALUES (30, 63562862881, '20/12/1965', 1196983.9715, 'M', 'Rua Domingos Olímpio 24') ;
INSERT INTO cliente VALUES (31, 49247999804, '28/03/1957', 1199226.3278, 'M', 'Rua Cristiano Olsen 514') ;
INSERT INTO cliente VALUES (32, 49418314894, '24/07/1962', 1197493.4115, 'M', 'Avenida Almirante Maximiano Fonseca 451') ;
INSERT INTO cliente VALUES (33, 65229680881, '25/12/1972', 1198196.0497, 'F', 'Rua Paracatu 444') ;
INSERT INTO cliente VALUES (34, 49841554852, '10/12/1998', 1199712.3127, 'M', 'Avenida Tocantins 2147') ;
INSERT INTO cliente VALUES (35, 80697692892, '16/05/1991', 1197639.3021, 'M', 'Rodovia Raposo Tavares 5878') ;
INSERT INTO cliente VALUES (36, 15566586805, '17/11/1977', 1198665.6871, 'F', 'Rua Barão de Vitória 265') ;
INSERT INTO cliente VALUES (37, 11043318887, '26/12/1985', 1198722.1581, 'F', 'Rua Frederico Moura 874') ;
INSERT INTO cliente VALUES (38, 04727344823, '15/03/2000', 1197461.8727, 'F', 'Avenida Governador José Malcher 323') ;
INSERT INTO cliente VALUES (39, 16494773842, '29/06/1951', 1199113.8461, 'F', 'Rua José Manoel da Fonseca Júnior 471') ;
INSERT INTO cliente VALUES (40, 74156976858, '28/05/2004', 1198515.8038, 'F', 'Rua Alagoas 444') ;
INSERT INTO cliente VALUES (41, 69984195899, '15/03/1956', 1198672.3683, 'M', 'Rua José Honorato 787') ;
INSERT INTO cliente VALUES (42, 38861008801, '20/10/1989', 1197405.6722, 'M', 'Rua Rio da Aldeia 147') ;
INSERT INTO cliente VALUES (43, 88816009861, '03/01/1960', 1196871.3565, 'M', 'Rua José Bonifácio 599') ;
INSERT INTO cliente VALUES (44, 96079993805, '04/04/1978', 1198227.1532, 'M', 'Rua Balão Mágico 465') ;
INSERT INTO cliente VALUES (45, 03761436815, '14/10/1976', 1197676.3683, 'F', ' Rua Maria das Dores 77') ;
INSERT INTO cliente VALUES (46, 05121463812, '13/02/1984', 1198168.5221, 'F', 'Rua José Carlos Laselva 222') ;
INSERT INTO cliente VALUES (47, 85094866893, '27/02/2004', 1198368.9916, 'F', 'Rua Bem-te-vi 454') ;
INSERT INTO cliente VALUES (48, 81775008800, '07/06/1968', 1197573.6817, 'M', 'Avenida Mogiana 1599') ;
INSERT INTO cliente VALUES (49, 73882377801, '05/05/1973', 1198179.4713, 'F', 'Rua Humberto Bianco 258') ;
INSERT INTO cliente VALUES (50, 37049863807, '27/06/2000', 1198307.8416, 'F', 'Rua Valentim Pinhata 587') ;
INSERT INTO cliente VALUES (51, 38532326803, '18/04/1967', 1198754.7793, 'M', 'Rua Valdir de Carvalho 332') ;
INSERT INTO cliente VALUES (52, 33966109891, '28/04/1967', 1198307.1768, 'M', 'Rua Benedito Miguel da Costa 4789') ;
INSERT INTO cliente VALUES (53, 23623970840, '26/06/1986', 1199748.2715, 'F', 'Rua Doutor Francisco de Assis Leme 44') ;
INSERT INTO cliente VALUES (54, 88354315819, '16/08/2002', 1197194.7736, 'F', 'Rua Maria Catarina Vasconcellos 69') ;
INSERT INTO cliente VALUES (55, 63469731853, '14/10/1972', 1197342.5924, 'F', 'Rua Engenheiro Agenor Machado 123') ;
INSERT INTO cliente VALUES (56, 96133873825, '20/12/1987', 1198762.2272, 'F', 'Rua Aparecida Helena da Costa 187') ;
INSERT INTO cliente VALUES (57, 49995715872, '18/03/2000', 1199371.1538, 'M', 'Avenida Presidente Kennedy 5325') ;
INSERT INTO cliente VALUES (58, 76176051886, '20/12/1994', 1197166.7913, 'F', 'Rua Seis 59') ;
INSERT INTO cliente VALUES (59, 40345670825, '28/03/1994', 1198318.8529, 'M', 'Avenida Vergueiro 888') ;
INSERT INTO cliente VALUES (60, 35152903890, '18/05/1956', 1199552.6354, 'M', 'Rua Estácio de Sá 2') ;
INSERT INTO cliente VALUES (61, 96561305884, '21/12/1949', 1199936.2389, 'F', 'Avenida Boa Vista 45') ;
INSERT INTO cliente VALUES (62, 97535361862, '16/04/1971', 1198953.7663, 'M', 'Rua Marechal Deodoro 59') ;
INSERT INTO cliente VALUES (63, 13273777800, '04/11/1977', 1197622.2389, 'F', 'Rua Raimundo Lopes de Almeida 122') ;
INSERT INTO cliente VALUES (64, 06256379845, '14/02/2003', 1198595.6655, 'M', 'Rua Xavantes 417') ;
INSERT INTO cliente VALUES (65, 10442631804, '24/10/1990', 1198858.8041, 'F', 'Rua Chaves 149') ;
INSERT INTO cliente VALUES (66, 71379288894, '09/06/1982', 1197627.2055, 'M', 'Rua Joaquim Carlos Wiss 126') ;
INSERT INTO cliente VALUES (67, 79710736825, '28/03/1958', 1197448.0465, 'M', 'Avenida Frederico Trostdorf Neto 111') ;
INSERT INTO cliente VALUES (68, 36674291854, '19/01/2000', 1190910.2248, 'F', 'Rua Senador Juraci Magalhães 599') ;
INSERT INTO cliente VALUES (69, 31904839819, '19/01/1996', 1199231.8129, 'M', 'Rua Antônio Garcia de Freitas 838') ;
INSERT INTO cliente VALUES (70, 44631588853, '30/08/1981', 1199971.3168, 'M', 'Avenida Jardim das Palmeiras 999') ;
INSERT INTO cliente VALUES (71, 15737476880, '17/11/1978', 1197277.6175, 'M', 'Passagem Palmácia 447') ;
INSERT INTO cliente VALUES (72, 18379811836, '02/05/1983', 1198317.1483, 'F', 'Rua Fausto Lyra Brandão 487') ;
INSERT INTO cliente VALUES (73, 96278776898, '06/11/1959', 1196773.1094, 'F', 'Rua Padre Antonio Toloi Stafuzza 111') ;
INSERT INTO cliente VALUES (74, 40681178884, '28/12/1940', 1198747.2512, 'F', 'Rua Maria do Céu Henrique Barbosa' ) ;
INSERT INTO cliente VALUES (75, 24109983800, '22/08/1933', 1198382.5386, 'M', 'Rua Antonio Luiz Ferrari 587') ;
INSERT INTO cliente VALUES (76, 97986699833, '27/05/1969', 1197349.7342, 'M', 'Rua Doutor Zuquim 229') ;
INSERT INTO cliente VALUES (77, 63316320857, '31/08/1948', 1197687.1283, 'M', 'Rua Periquito 798') ;
INSERT INTO cliente VALUES (78, 71068216832, '07/01/1945', 1198688.5083, 'F', 'Rua Jacarezinho 541') ;
INSERT INTO cliente VALUES (79, 15442687855, '07/10/1935', 1197327.5493, 'M', 'Rua Um 379') ;
INSERT INTO cliente VALUES (80, 64595397828, '30/04/1945', 1198016.2222, 'M', 'Rua Charinas 292') ;
INSERT INTO cliente VALUES (81, 53595071875, '24/07/1952', 1199303.8354, 'M', 'Alameda Manacá da Serra 597') ;
INSERT INTO cliente VALUES (82, 83227970872, '15/04/1934', 1198523.6656, 'F', 'Rua João Cosmai 125') ;
INSERT INTO cliente VALUES (83, 15297085837, '23/03/1954', 1197173.5636, 'M', ' Rua Jasper Bresler 666') ;
INSERT INTO cliente VALUES (84, 06142813856, '16/04/1972', 1199729.0955, 'M', 'Rua Abrahão Jorge Miguel 979') ;
INSERT INTO cliente VALUES (85, 26289791877, '28/11/1994', 1198280.4284, 'F', 'Rua Maria Cândida Ferreira Lacerda 878') ;
INSERT INTO cliente VALUES (86, 33095868804, '01/05/1960', 1197589.6130, 'M', 'Avenida José Oscar Gratti 2865') ;
INSERT INTO cliente VALUES (87, 34333722845, '06/06/1943', 1198884.2427, 'F', 'Rua Mariana Raphael 365') ;
INSERT INTO cliente VALUES (88, 91331901863, '22/10/1954', 1199914.1728, 'F', 'Rua Rosa Calegari List 265') ;
INSERT INTO cliente VALUES (89, 65184609890, '20/10/2001', 1199675.8913, 'F', 'Avenida Sapopemba 3286') ;
INSERT INTO cliente VALUES (90, 67372102871, '11/12/1984', 1198373.5743, 'F', 'Rua Cezário Buratto 559') ;
INSERT INTO cliente VALUES (91, 62159627836, '05/10/1976', 1199814.6936, 'F', 'Avenida Euclides Fonseca 323') ;
INSERT INTO cliente VALUES (92, 92853627888, '13/10/1971', 1198818.9817, 'F', 'Rua Luiz Fantini 245') ;
INSERT INTO cliente VALUES (93, 39064866805, '30/03/1945', 1197905.7551, 'M', 'Rua Fausto Luís Pina 449') ;
INSERT INTO cliente VALUES (94, 99689600800, '04/11/1994', 1199558.8663, 'M', 'Rua Ângelo Briches 111') ;
INSERT INTO cliente VALUES (95, 47061399880, '01/02/1980', 1198115.0379, 'M', 'Rua Ibirá Barbalho Lopes 123') ;
INSERT INTO cliente VALUES (96, 83978049864, '10/01/1956', 1198342.3864, 'M', 'Avenida Papa João XXIII 147') ;
INSERT INTO cliente VALUES (97, 57788064858, '30/06/1987', 1196941.1728, 'F', 'Rua Rio Duas Barras 397') ;
INSERT INTO cliente VALUES (98, 47246339809, '11/05/2002', 1196972.4820, 'M', 'Rua Manoel Francisco 658') ;
INSERT INTO cliente VALUES (99, 45153670805, '12/11/1963', 1197281.5256, 'M', 'Praça Sérgio Bisofi 22') ;
INSERT INTO cliente VALUES (100, 04841656820, '30/08/1952', 1198381.2686, 'F', 'Rua Domingos de Genaro Neto 45') ;

-- Populando tabela medicamento 

SELECT * FROM medicamento

INSERT INTO medicamento VALUES ('Azitromicina 500mg', '10/05/2022', '10/05/2020', 47, '01/06/2022', 45 , 22.50, 'antibiótico', 'comprimido 5 cps',
'vermelha', 10) ;
INSERT INTO medicamento VALUES ('Rivotril 0,25mg', '10/01/2022', '10/01/2021', 20, '01/06/2022', 25, 37.80, 'psicotrópico', 'líquido gotas 10mL',
'preta', 11) ;
INSERT INTO medicamento VALUES ('Clavulin BD 875mg', '31/01/2024', '01/04/2020', 15, '02/06/2022' , 20, 79.03, 'antibiótico', 'comprimido 14 cps',
'vermelha', 12) ;
INSERT INTO medicamento VALUES ('Sertralina 50mg', '31/05/2024', '31/05/2022', 10, '02/06/2022', 30, 33.80, 'psicotrópico', 'comprimido 30 cps',
'vermelha', 13) ;
INSERT INTO medicamento VALUES ('Zinnat 500mg', '31/01/2024', '01/04/2020', 5, '03/06/2022' , 5, 250, 'antibiótico', 'comprimido 14 cps',
'vermelha', 14) ;
INSERT INTO medicamento VALUES ('Zinnat 500mg', '31/01/2024', '01/04/2020', 5, '03/06/2022' , 4, 300, 'antibiótico', 'comprimido 20 cps',
'vermelha', 15) ;
INSERT INTO medicamento VALUES ('Escitalopram 15mg', '01/05/2022', '01/06/2020', 6, '04/06/2022', 8, 50.00, 'psicotrópico', 'líquido gotas 20mL',
'vermelha', 16) ;
INSERT INTO medicamento VALUES ('Biomag 10mg', '01/01/2022', '01/01/2020', 3, '04/06/2022', 3, 88.00, 'psicotrópico', ' cápsula 30 caps',
'preta', 17) ;
INSERT INTO medicamento VALUES ('Cefalexina 500mg', '01/08/2022', '01/08/2020', 15, '05/06/2022', 15, 40.00, 'antibiótico', ' cápsula 8 cps',
'vermelha', 18) ;
INSERT INTO medicamento VALUES ('Cefadroxila 500mg', '30/11/2022', '30/11/2020', 15, '05/06/2022', 20, 23.75, 'antibiótico', ' cápsula 15 cps',
'vermelha', 19) ;
INSERT INTO medicamento VALUES ('Tramadol 10mg', '31/12/2022', '31/12/2020', 25, '06/06/2022', 25, 18.00, 'psicotrópico', ' cápsula 10 cps',
'vermelha', 20) ;
INSERT INTO medicamento VALUES ('Tramadol 10mg/mL', '31/12/2022', '31/12/2020', 25, '06/06/2022', 15, 150, 'psicotrópico', 'líquido 10mL',
'vermelha', 21) ;
INSERT INTO medicamento VALUES ('Tramadol 100mg', '30/08/2022', '30/08/2020', 3, '07/06/2022', 3, 150, 'psicotrópico', ' cápsula 10cps',
'vermelha', 22) ;
INSERT INTO medicamento VALUES ('Alprazolam', '01/05/2022', '30/06/2020', 10, '07/06/2022', 10, 22.50, 'psicotrópico', ' cápsula 30 cps',
'preta', 23) ;
INSERT INTO medicamento VALUES ('Keflex 1g', '30/04/2022', '30/04/2020', 5, '08/06/2022', 5, 98.70, 'antibiótico', ' cápsula 8 cps',
'vermelha', 24) ;
INSERT INTO medicamento VALUES ('Keflex 500mg', '30/10/2022', '30/06/2020', 15, '08/06/2022', 10, 54.60, 'antibiótico', ' cápsula 16 cps',
'vermelha', 25) ;
INSERT INTO medicamento VALUES ('Fluoxetina 10mg', '31/10/2022', '30/10/2020', 40, '09/06/2022', 45, 18.60, 'psicotrópico', ' cápsula 30 cps',
'vermelha', 26) ;
INSERT INTO medicamento VALUES ('Prozac 10mg', '31/10/2023', '30/10/2021', 15, '09/06/2022', 15, 95.60, 'psicotrópico', ' cápsula 30 cps',
'vermelha', 27) ;
INSERT INTO medicamento VALUES ('Reconter 15mg', '30/08/2022', '30/08/2020', 5, '01/06/2022', 2, 150.75, 'psicotrópico', 'comprimido 30 cps',
'vermelha', 28) ;
INSERT INTO medicamento VALUES ('Reconter 20mg/mL', '31/05/2024', '31/05/2022', 5, '10/06/2022', 5, 44.85, 'psicotrópico', 'líquido 20mL',
'vermelha', 29) ;
INSERT INTO medicamento VALUES ('Equilid 50mg', '31/01/2023', '31/01/2021', 6, '10/06/2022', 6, 38.75, 'psicotrópico', 'comprimido 20cps',
'vermelha', 30) ;
INSERT INTO medicamento VALUES ('Equilid 200mg', '28/02/2024', '28/02/2022', 3, '10/06/2022', 3, 95.75, 'psicotrópico', 'comprimido 30cps',
'vermelha', 31) ;
INSERT INTO medicamento VALUES ('Zinnat 250mg/mL', '30/04/2024', '30/04/2022', 6, '11/06/2022', 0, 78.90, 'antibiótico', 'líquido 70mL',
'vermelha', 32) ;
INSERT INTO medicamento VALUES ('Keppra 100mg/mL', '01/05/2022', '31/05/2021', 22, '11/06/2022', 20, 120.10, 'psicotrópico', 'líquido 150mL',
'vermelha', 33) ;
INSERT INTO medicamento VALUES ('Clavulin BD', '01/05/2022', '31/05/2021', 6, '12/06/2022', 4, 98.00, 'antibiótico', 'líquido 100mL',
'vermelha', 34) ;
INSERT INTO medicamento VALUES ('Gardenal 100mg', '31/05/2024', '31/05/2022', 35, '12/06/2022', 35, 12.00, 'psicotrópico', 'comprimido 20cps',
'vermelha', 35) ;
INSERT INTO medicamento VALUES ('Luvox 50mg', '30/04/2022', '30/11/2020', 2, '13/06/2022', 1, 175.50, 'psicotrópico', 'comprimido 60cps',
'vermelha', 36) ;
INSERT INTO medicamento VALUES ('Depakene 250mg/mL', '30/11/2023', '30/11/2021', 20, '13/06/2022', 15, 65.85, 'psicotrópico', 'líquido 150mL',
'vermelha', 37) ;
INSERT INTO medicamento VALUES ('Canabidiol 30mg/mL', '30/04/2022', '30/10/2020', 2, '14/06/2022', 1, 99.90, 'psicotrópico', 'líquido 150mL',
'preta', 38) ;
INSERT INTO medicamento VALUES ('Rivotril 0,5mg', '01/04/2024', '01/04/2020', 10, '14/06/2022', 15, 12.75, 'psicotrópico', 'comprimido 30cps',
'preta',39) ;
INSERT INTO medicamento VALUES ('Amoxicilina 500mg', '30/11/2023', '30/11/2021', 12, '15/06/2022', 15, 22.75, 'antibiótico', 'comprimido 21cps',
'vermelha', 40) ;
INSERT INTO medicamento VALUES ('Levofloxacino 500mg', '30/11/2023', '30/11/2021', 4, '15/06/2022', 4, 44.90, 'antibiótico', 'comprimido 7cps',
'vermelha', 41) ;
INSERT INTO medicamento VALUES ('Levofloxacino 750mg', '30/11/2023', '30/11/2021', 3, '16/06/2022', 3 , 65.70, 'antibiótico', 'comprimido 5cps',
'vermelha', 42) ;
INSERT INTO medicamento VALUES ('Trivagel CR', '30/08/2024', '30/08/2020', 5, '16/06/2022', 4, 88.95, 'antibiótico', 'Creme Vaginal 30G',
'vermelha', 43) ;
INSERT INTO medicamento VALUES ('Venvanse 30mg', '30/11/2023', '30/11/2021', 4, '17/06/2022', 5, 410.00, 'psicotrópico', 'comprimido 30cps',
'preta', 44) ;
INSERT INTO medicamento VALUES ('Venvanse 50mg', '30/09/2023', '30/09/2021', 4, '17/06/2022', 4, 375.50, 'psicotrópico', 'comprimido 30cps',
'preta', 45) ;
INSERT INTO medicamento VALUES ('Venvanse 70mg', '30/09/2023', '30/09/2021', 4, '18/06/2022', 3, 310.50, 'psicotrópico', 'comprimido 30cps',
'preta', 46) ;
INSERT INTO medicamento VALUES ('Monuril 3.735G', '30/03/2022', '28/02/2022', 12, '18/06/2022', 15, 65.40, 'antibiótico', '1 envelope',
'vermelha', 47) ;
INSERT INTO medicamento VALUES ('Monuril 3.735G', '30/03/2022', '28/02/2022', 15, '19/06/2022', 18, 49.90, 'antibiótico', '2 envelope',
'vermelha', 48) ;
INSERT INTO medicamento VALUES ('Metronidazol 250mg', '31/10/2022', '30/01/2022', 15, '19/06/2022', 15, 27.85, 'antibiótico', ' cápsula 20cps',
'vermelha', 49) ;

-- Populando tabela estoque (90 dias)

INSERT INTO estoque VALUES ('01/03/2022', 22270) ;
INSERT INTO estoque VALUES ('02/03/2022', 22271) ;
INSERT INTO estoque VALUES ('03/03/2022', 22272) ;
INSERT INTO estoque VALUES ('04/03/2022', 22273) ;
INSERT INTO estoque VALUES ('05/03/2022', 22274) ;
INSERT INTO estoque VALUES ('06/03/2022', 22275) ;
INSERT INTO estoque VALUES ('07/03/2022', 22276) ;
INSERT INTO estoque VALUES ('08/03/2022', 22277) ;
INSERT INTO estoque VALUES ('09/03/2022', 22278) ;
INSERT INTO estoque VALUES ('10/03/2022', 22279) ;
INSERT INTO estoque VALUES ('11/03/2022', 22280) ;
INSERT INTO estoque VALUES ('12/03/2022', 22281) ;
INSERT INTO estoque VALUES ('13/03/2022', 22282) ;
INSERT INTO estoque VALUES ('14/03/2022', 22283) ;
INSERT INTO estoque VALUES ('15/03/2022', 22284) ;
INSERT INTO estoque VALUES ('16/03/2022', 22285) ;
INSERT INTO estoque VALUES ('17/03/2022', 22286) ;
INSERT INTO estoque VALUES ('18/03/2022', 22287) ;
INSERT INTO estoque VALUES ('19/03/2022', 22288) ;
INSERT INTO estoque VALUES ('20/03/2022', 22289) ;
INSERT INTO estoque VALUES ('21/03/2022', 22290) ;
INSERT INTO estoque VALUES ('22/03/2022', 22291) ;
INSERT INTO estoque VALUES ('23/03/2022', 22292) ;
INSERT INTO estoque VALUES ('24/03/2022', 22293) ;
INSERT INTO estoque VALUES ('25/03/2022', 22294) ;
INSERT INTO estoque VALUES ('26/03/2022', 22295) ;
INSERT INTO estoque VALUES ('27/03/2022', 22296) ;
INSERT INTO estoque VALUES ('28/03/2022', 22297) ;
INSERT INTO estoque VALUES ('29/03/2022', 22298) ;
INSERT INTO estoque VALUES ('30/03/2022', 22299) ;
INSERT INTO estoque VALUES ('31/03/2022', 22300) ;
INSERT INTO estoque VALUES ('01/04/2022', 22301) ;
INSERT INTO estoque VALUES ('02/04/2022', 22302) ;
INSERT INTO estoque VALUES ('03/04/2022', 22303) ;
INSERT INTO estoque VALUES ('04/04/2022', 22304) ;
INSERT INTO estoque VALUES ('05/04/2022', 22305) ;
INSERT INTO estoque VALUES ('06/04/2022', 22306) ;
INSERT INTO estoque VALUES ('07/04/2022', 22307) ;
INSERT INTO estoque VALUES ('08/04/2022', 22308) ;
INSERT INTO estoque VALUES ('09/04/2022', 22309) ;
INSERT INTO estoque VALUES ('10/04/2022', 22310) ;
INSERT INTO estoque VALUES ('11/04/2022', 22311) ;
INSERT INTO estoque VALUES ('12/04/2022', 22312) ;
INSERT INTO estoque VALUES ('13/04/2022', 22313) ;
INSERT INTO estoque VALUES ('14/04/2022', 22314) ;
INSERT INTO estoque VALUES ('15/04/2022', 22315) ;
INSERT INTO estoque VALUES ('16/04/2022', 22316) ;
INSERT INTO estoque VALUES ('17/04/2022', 22317) ;
INSERT INTO estoque VALUES ('18/04/2022', 22318) ;
INSERT INTO estoque VALUES ('19/04/2022', 22319) ;
INSERT INTO estoque VALUES ('20/04/2022', 22320) ;
INSERT INTO estoque VALUES ('21/04/2022', 22321) ;
INSERT INTO estoque VALUES ('22/04/2022', 22322) ;
INSERT INTO estoque VALUES ('23/04/2022', 22323) ;
INSERT INTO estoque VALUES ('24/04/2022', 22324) ;
INSERT INTO estoque VALUES ('25/04/2022', 22325) ;
INSERT INTO estoque VALUES ('26/04/2022', 22326) ;
INSERT INTO estoque VALUES ('27/04/2022', 22327) ;
INSERT INTO estoque VALUES ('28/04/2022', 22328) ;
INSERT INTO estoque VALUES ('29/04/2022', 22329) ;
INSERT INTO estoque VALUES ('30/04/2022', 22330) ;
INSERT INTO estoque VALUES ('01/05/2022', 22331) ;
INSERT INTO estoque VALUES ('02/05/2022', 22332) ;
INSERT INTO estoque VALUES ('03/05/2022', 22333) ;
INSERT INTO estoque VALUES ('04/05/2022', 22334) ;
INSERT INTO estoque VALUES ('05/05/2022', 22335) ;
INSERT INTO estoque VALUES ('06/05/2022', 22336) ;
INSERT INTO estoque VALUES ('07/05/2022', 22337) ;
INSERT INTO estoque VALUES ('08/05/2022', 22338) ;
INSERT INTO estoque VALUES ('09/05/2022', 22339) ;
INSERT INTO estoque VALUES ('10/05/2022', 22340) ;
INSERT INTO estoque VALUES ('11/05/2022', 22341) ;
INSERT INTO estoque VALUES ('12/05/2022', 22342) ;
INSERT INTO estoque VALUES ('13/05/2022', 22343) ;
INSERT INTO estoque VALUES ('14/05/2022', 22344) ;
INSERT INTO estoque VALUES ('15/05/2022', 22345) ;
INSERT INTO estoque VALUES ('16/05/2022', 22346) ;
INSERT INTO estoque VALUES ('17/05/2022', 22347) ;
INSERT INTO estoque VALUES ('18/05/2022', 22348) ;
INSERT INTO estoque VALUES ('19/05/2022', 22349) ;
INSERT INTO estoque VALUES ('20/05/2022', 22350) ;
INSERT INTO estoque VALUES ('21/05/2022', 22351) ;
INSERT INTO estoque VALUES ('22/05/2022', 22352) ;
INSERT INTO estoque VALUES ('23/05/2022', 22353) ;
INSERT INTO estoque VALUES ('24/05/2022', 22354) ;
INSERT INTO estoque VALUES ('25/05/2022', 22355) ;
INSERT INTO estoque VALUES ('26/05/2022', 22356) ;
INSERT INTO estoque VALUES ('27/05/2022', 22357) ;
INSERT INTO estoque VALUES ('28/05/2022', 22358) ;
INSERT INTO estoque VALUES ('29/05/2022', 22359) ;
INSERT INTO estoque VALUES ('30/05/2022', 22360) ;
INSERT INTO estoque VALUES ('31/05/2022', 22361) ;
INSERT INTO estoque VALUES ('01/06/2022', 22362) ;
INSERT INTO estoque VALUES ('02/06/2022', 22363) ;
INSERT INTO estoque VALUES ('03/06/2022', 22364) ;
INSERT INTO estoque VALUES ('04/06/2022', 22365) ;
INSERT INTO estoque VALUES ('05/06/2022', 22366) ;
INSERT INTO estoque VALUES ('06/06/2022', 22367) ;
INSERT INTO estoque VALUES ('07/06/2022', 22368) ;
INSERT INTO estoque VALUES ('08/06/2022', 22369) ;
INSERT INTO estoque VALUES ('09/06/2022', 22370) ;
INSERT INTO estoque VALUES ('10/06/2022', 22371) ;
INSERT INTO estoque VALUES ('11/06/2022', 22372) ;
INSERT INTO estoque VALUES ('12/06/2022', 22373) ;
INSERT INTO estoque VALUES ('13/06/2022', 22374) ;
INSERT INTO estoque VALUES ('14/06/2022', 22375) ;
INSERT INTO estoque VALUES ('15/06/2022', 22376) ;
INSERT INTO estoque VALUES ('16/06/2022', 22377) ;
INSERT INTO estoque VALUES ('17/06/2022', 22378) ;
INSERT INTO estoque VALUES ('18/06/2022', 22379) ;
INSERT INTO estoque VALUES ('19/06/2022', 22380) ;

-- Populando tabela pedido (100 registros)

INSERT INTO pedido VALUES (100, 1, '02/05/2022', 1, 'COMPRA', null, 10) ;
INSERT INTO pedido VALUES (101, 2, '02/05/2022', 2, 'DEVOLUÇÃO', 6555, 13) ; 
INSERT INTO pedido VALUES (102, 1, '02/05/2022', 3, 'COMPRA', null, 12) ;
INSERT INTO pedido VALUES (103, 6, '02/05/2022', 4, 'COMPRA', null, 20) ;
INSERT INTO pedido VALUES (104, 2, '02/05/2022', 5, 'COMPRA', null, 27) ;
INSERT INTO pedido VALUES (105, 2, '02/05/2022', 6, 'COMPRA', null, 12) ;
INSERT INTO pedido VALUES (106, 2, '02/05/2022', 7, 'COMPRA', null, 21) ;
INSERT INTO pedido VALUES (107, 6, '02/05/2022', 8, 'COMPRA', null, 20) ;
INSERT INTO pedido VALUES (108, 3, '02/05/2022', 9, 'COMPRA', null, 31) ;
INSERT INTO pedido VALUES (109, 6, '02/05/2022', 10, 'COMPRA', null, 13) ;
INSERT INTO pedido VALUES (110, 4, '02/05/2022', 11, 'COMPRA', null, 13) ;
INSERT INTO pedido VALUES (111, 5, '02/05/2022', 12, 'COMPRA', null, 28) ;
INSERT INTO pedido VALUES (112, 26, '02/05/2022', 13, 'COMPRA', null, 26) ;
INSERT INTO pedido VALUES (113, 4, '03/05/2022', 14, 'DEVOLUÇÃO', 6556, 10) ;
INSERT INTO pedido VALUES (114, 2, '03/05/2022', 15, 'COMPRA', null, 35) ;
INSERT INTO pedido VALUES (115, 16, '03/05/2022', 16, 'COMPRA', null, 17) ;
INSERT INTO pedido VALUES (116, 12, '03/05/2022', 17, 'COMPRA', null, 22) ;
INSERT INTO pedido VALUES (117, 36, '03/05/2022', 18, 'COMPRA', null, 44) ;
INSERT INTO pedido VALUES (118, 12, '03/05/2022', 19, 'COMPRA', null, 43) ;
INSERT INTO pedido VALUES (119, 4, '03/05/2022', 20, 'COMPRA', null, 28) ;
INSERT INTO pedido VALUES (120, 1, '03/05/2022', 21, 'DEVOLUÇÃO', 6557, 30) ;
INSERT INTO pedido VALUES (121, 2, '03/05/2022', 22, 'COMPRA', null, 31) ;
INSERT INTO pedido VALUES (122, 12, '04/05/2022', 23, 'COMPRA', null, 49) ;
INSERT INTO pedido VALUES (123, 2, '04/05/2022', 24, 'COMPRA', null, 48) ;
INSERT INTO pedido VALUES (124, 4, '04/05/2022', 25, 'COMPRA', null, 12) ;
INSERT INTO pedido VALUES (125, 1, '04/05/2022', 26, 'COMPRA', null, 44) ;
INSERT INTO pedido VALUES (126, 3, '04/05/2022', 27, 'COMPRA', null,22) ;
INSERT INTO pedido VALUES (127, 5, '04/05/2022', 28, 'DEVOLUÇÃO', 6558, 23) ;
INSERT INTO pedido VALUES (128, 1, '04/05/2022', 29, 'COMPRA', null, 10) ;
INSERT INTO pedido VALUES (129, 2, '04/05/2022', 30, 'COMPRA', null, 33) ;
INSERT INTO pedido VALUES (130, 2, '04/05/2022', 31, 'COMPRA', null, 31) ;
INSERT INTO pedido VALUES (131, 6, '04/05/2022', 32, 'COMPRA', null, 10) ;
INSERT INTO pedido VALUES (132, 5, '04/05/2022', 33, 'COMPRA', null, 10) ;
INSERT INTO pedido VALUES (133, 4, '04/05/2022', 34, 'DEVOLUÇÃO', 6559, 11) ;
INSERT INTO pedido VALUES (134, 4, '04/05/2022', 35, 'COMPRA', null, 12) ;
INSERT INTO pedido VALUES (135, 2, '04/05/2022', 36, 'COMPRA', null, 30) ;
INSERT INTO pedido VALUES (136, 2, '04/05/2022', 37, 'COMPRA', null, 41) ;
INSERT INTO pedido VALUES (137, 1, '05/05/2022', 38, 'COMPRA', null, 42) ;
INSERT INTO pedido VALUES (138, 1, '05/05/2022', 39, 'COMPRA', null, 49) ;
INSERT INTO pedido VALUES (139, 3, '05/05/2022', 40, 'COMPRA', null, 13) ;
INSERT INTO pedido VALUES (140, 2, '05/05/2022', 41, 'COMPRA', null, 18) ;
INSERT INTO pedido VALUES (141, 2, '05/05/2022', 42, 'DEVOLUÇÃO', 6560, 48) ;

-- Testando compras de clientes que já são da loja e estão fazendo novos pedidos (ou devoluções).

INSERT INTO pedido VALUES (142, 2, '05/06/2022', 1, 'COMPRA', null, 10) ;
INSERT INTO pedido VALUES (143, 1, '05/06/2022', 5, 'COMPRA', null, 10) ;
INSERT INTO pedido VALUES (144, 4, '05/06/2022', 10, 'COMPRA', null, 15) ;
INSERT INTO pedido VALUES (145, 1, '05/06/2022', 11, 'COMPRA', null, 12) ;
INSERT INTO pedido VALUES (146, 1, '05/06/2022', 42, 'COMPRA', null, 30) ;
INSERT INTO pedido VALUES (147, 2, '05/06/2022', 40, 'COMPRA', null, 42) ;
INSERT INTO pedido VALUES (148, 2, '06/06/2022', 7, 'COMPRA', null, 14) ;
INSERT INTO pedido VALUES (149, 2, '06/06/2022', 9, 'COMPRA', null, 15) ;
INSERT INTO pedido VALUES (150, 4, '06/06/2022', 21, 'DEVOLUÇÃO', 6560, 27) ;
INSERT INTO pedido VALUES (151, 2, '06/06/2022', 23, 'DEVOLUÇÃO', 6561, 29) ;
INSERT INTO pedido VALUES (152, 3, '06/06/2022', 15, 'COMPRA', null, 12) ;
INSERT INTO pedido VALUES (153, 2, '06/06/2022', 19, 'COMPRA', null, 15) ;
INSERT INTO pedido VALUES (154, 1, '06/06/2022', 31, 'COMPRA', null, 11) ;
INSERT INTO pedido VALUES (155, 1, '06/06/2022', 39, 'COMPRA', null, 44) ;
INSERT INTO pedido VALUES (156, 2, '06/06/2022', 28, 'DEVOLUÇÃO', 6562, 21) ;
INSERT INTO pedido VALUES (157, 2, '07/06/2022', 28, 'COMPRA', null, 21) ;
INSERT INTO pedido VALUES (158, 2, '07/06/2022', 42, 'COMPRA', null,20) ;
INSERT INTO pedido VALUES (159, 1, '07/06/2022', 40, 'COMPRA', null, 36) ;
INSERT INTO pedido VALUES (160, 4, '07/06/2022', 4, 'DEVOLUÇÃO', 6563, 22) ;
INSERT INTO pedido VALUES (161, 4, '07/06/2022', 2, 'COMPRA', null, 47) ;
INSERT INTO pedido VALUES (162, 1, '07/06/2022', 33, 'COMPRA', null, 19) ;
INSERT INTO pedido VALUES (163, 1, '07/06/2022', 12, 'COMPRA', null, 41) ;
INSERT INTO pedido VALUES (164, 1, '08/06/2022', 11, 'DEVOLUÇÃO', 6564, 27) ;
INSERT INTO pedido VALUES (165, 2, '08/06/2022', 41, 'COMPRA', null, 50) ;
INSERT INTO pedido VALUES (166, 2, '08/06/2022', 28, 'COMPRA', null, 32) ;
INSERT INTO pedido VALUES (167, 3, '08/06/2022', 40, 'COMPRA', null, 33) ;
INSERT INTO pedido VALUES (168, 5, '08/06/2022', 15, 'COMPRA', null, 11) ;
INSERT INTO pedido VALUES (169, 3, '08/06/2022', 19, 'COMPRA', null, 18) ;
INSERT INTO pedido VALUES (170, 3, '09/06/2022', 8, 'COMPRA', null, 34) ;
INSERT INTO pedido VALUES (171, 2, '09/06/2022', 2, 'COMPRA', null, 28) ;
INSERT INTO pedido VALUES (172, 2, '09/06/2022', 13, 'DEVOLUÇÃO', 6466, 13) ;
INSERT INTO pedido VALUES (173, 2, '09/06/2022', 29, 'COMPRA', null, 12) ;
INSERT INTO pedido VALUES (174, 1, '09/06/2022', 41, 'COMPRA', null, 21) ;
INSERT INTO pedido VALUES (175, 1, '10/06/2022', 42, 'DEVOLUÇÃO', 6567, 20) ;
INSERT INTO pedido VALUES (176, 1, '10/06/2022', 7, 'COMPRA', null, 42) ;
INSERT INTO pedido VALUES (177, 1, '10/06/2022', 5, 'COMPRA', null, 44) ;
INSERT INTO pedido VALUES (178, 3, '10/06/2022', 9, 'COMPRA', null, 47) ;
INSERT INTO pedido VALUES (179, 2, '10/06/2022', 23, 'COMPRA', null, 44) ;
INSERT INTO pedido VALUES (180, 3, '10/06/2022', 45, 'COMPRA', null, 47) ;
INSERT INTO pedido VALUES (181, 2, '10/06/2022', 40, 'COMPRA', null, 12) ;
INSERT INTO pedido VALUES (182, 1, '10/06/2022', 38, 'COMPRA', null, 30) ;
INSERT INTO pedido VALUES (183, 1, '10/06/2022', 36, 'COMPRA', null, 29) ;
INSERT INTO pedido VALUES (184, 2, '10/06/2022', 33, 'COMPRA', null, 42) ;
INSERT INTO pedido VALUES (185, 2, '10/06/2022', 2, 'COMPRA', null, 15) ;
INSERT INTO pedido VALUES (186, 2, '11/06/2022', 21, 'COMPRA', null, 16) ;
INSERT INTO pedido VALUES (187, 1, '11/06/2022', 27, 'COMPRA', null, 44) ;
INSERT INTO pedido VALUES (188, 2, '11/06/2022', 30, 'COMPRA', null, 12) ;
INSERT INTO pedido VALUES (189, 4, '11/06/2022', 24, 'DEVOLUÇÃO', 6568, 22) ;
INSERT INTO pedido VALUES (190, 2, '11/06/2022', 29, 'COMPRA', null, 27) ;
INSERT INTO pedido VALUES (191, 4, '11/06/2022', 11, 'COMPRA', null, 17) ;
INSERT INTO pedido VALUES (192, 3, '11/06/2022', 17, 'COMPRA', null, 20) ;
INSERT INTO pedido VALUES (193, 1, '12/06/2022', 18, 'COMPRA', null, 20) ;
INSERT INTO pedido VALUES (194, 1, '12/06/2022', 40, 'DEVOLUÇÃO', 6569, 22) ;
INSERT INTO pedido VALUES (195, 1, '12/06/2022', 41, 'DEVOLUÇÃO', 6570, 10) ;
INSERT INTO pedido VALUES (196, 2, '12/06/2022', 2, 'COMPRA', null, 13) ;
INSERT INTO pedido VALUES (197, 3, '12/06/2022', 3, 'COMPRA', null, 14) ;
INSERT INTO pedido VALUES (198, 3, '12/06/2022', 12, 'COMPRA', null, 29) ;
INSERT INTO pedido VALUES (199, 4, '12/06/2022', 29, 'COMPRA', null, 33) ;

-- Populando tabela baixa_estoque (precisa bater com pedido e estoque) 

INSERT INTO baixa_estoque VALUES (13, '09/05/2022', 112, null, 22211, '09/05/2022', 10 ) ;  
INSERT INTO baixa_estoque VALUES (14, '10/05/2022', 113, null, 22211, '10/05/2022', 12 ) ;
INSERT INTO baixa_estoque VALUES (15, '10/05/2022', 114, 6558, 22211, '10/05/2022', 23 ) ;
INSERT INTO baixa_estoque VALUES (16, '11/05/2022', 115, null, 22211, '10/05/2022', 13 ) ;
INSERT INTO baixa_estoque VALUES (17, '12/05/2022', 116, null, 22211, '11/05/2022', 10 ) ;
INSERT INTO baixa_estoque VALUES (18, '13/05/2022', 117, null, 22211, '12/05/2022', 42 ) ;
INSERT INTO baixa_estoque VALUES (19, '13/05/2022', 118, null, 22211, '12/05/2022', 49 ) ;
INSERT INTO baixa_estoque VALUES (20, '14/05/2022', 119, null, 22211, '13/05/2022', 31 ) ;
INSERT INTO baixa_estoque VALUES (21, '14/05/2022', 120, null, 22211, '13/05/2022', 29 ) ;
INSERT INTO baixa_estoque VALUES (22, '14/05/2022', 121, null, 22211, '14/05/2022', 20 ) ;
INSERT INTO baixa_estoque VALUES (23, '15/05/2022', 122, null, 22211, '15/05/2022', 18 ) ;
INSERT INTO baixa_estoque VALUES (24, '16/05/2022', 123, null, 22211, '16/05/2022', 44 ) ;
INSERT INTO baixa_estoque VALUES (25, '17/05/2022', 124, null, 22211, '17/05/2022', 36 ) ;
INSERT INTO baixa_estoque VALUES (26, '18/05/2022', 125, 6559, 22211, '18/05/2022', 37 ) ;
INSERT INTO baixa_estoque VALUES (27, '19/05/2022', 126, null, 22211, '19/05/2022', 19 ) ;
INSERT INTO baixa_estoque VALUES (28, '19/05/2022', 127, null, 22211, '19/05/2022', 12 ) ;
INSERT INTO baixa_estoque VALUES (29, '20/05/2022', 128, null, 22211, '20/05/2022', 22 ) ;
INSERT INTO baixa_estoque VALUES (30, '21/05/2022', 129, null, 22211, '21/05/2022', 23 ) ;
INSERT INTO baixa_estoque VALUES (31, '23/05/2022', 130, null, 22211, '22/05/2022', 18 ) ;
INSERT INTO baixa_estoque VALUES (32, '23/05/2022', 131, null, 22211, '22/05/2022', 25 ) ;
INSERT INTO baixa_estoque VALUES (33, '23/05/2022', 100, null, 22211, '23/05/2022', 42 ) ;
INSERT INTO baixa_estoque VALUES (34, '24/05/2022', 132, null, 22211, '24/05/2022', 32 ) ;
INSERT INTO baixa_estoque VALUES (35, '25/05/2022', 133, 6560, 22211, '25/05/2022', 49 ) ;
INSERT INTO baixa_estoque VALUES (36, '26/05/2022', 134, null, 22211, '26/05/2022', 48 ) ;
INSERT INTO baixa_estoque VALUES (37, '28/05/2022', 135, null, 22211, '27/05/2022', 11 ) ;
INSERT INTO baixa_estoque VALUES (38, '28/05/2022', 136, null, 22211, '28/05/2022', 15 ) ;
INSERT INTO baixa_estoque VALUES (39, '29/05/2022', 137, null, 22211, '29/05/2022', 41 ) ;
INSERT INTO baixa_estoque VALUES (40, '30/05/2022', 138, null, 22211, '30/05/2022', 39 ) ;
INSERT INTO baixa_estoque VALUES (41, '31/05/2022', 139, null, 22211, '31/05/2022', 16 ) ;
INSERT INTO baixa_estoque VALUES (42, '01/06/2022', 140, null, 22211, '01/06/2022', 18 ) ;
INSERT INTO baixa_estoque VALUES (43, '02/06/2022', 141, null, 22211, '02/06/2022', 10 ) ;
INSERT INTO baixa_estoque VALUES (44, '03/06/2022', 142, 6561, 22211, '03/06/2022', 29 ) ;
INSERT INTO baixa_estoque VALUES (45, '03/06/2022', 143, null, 22211, '03/06/2022', 13 ) ;
INSERT INTO baixa_estoque VALUES (46, '05/06/2022', 144, null, 22211, '04/06/2022', 41 ) ;
INSERT INTO baixa_estoque VALUES (47, '05/06/2022', 145, null, 22211, '05/06/2022', 42 ) ;
INSERT INTO baixa_estoque VALUES (48, '06/06/2022', 146, 6562, 22211, '06/06/2022', 21 ) ;
INSERT INTO baixa_estoque VALUES (49, '07/06/2022', 147, null, 22211, '06/06/2022', 49 ) ;
INSERT INTO baixa_estoque VALUES (50, '07/06/2022', 148, null, 22211, '06/06/2022', 17 ) ;
INSERT INTO baixa_estoque VALUES (51, '07/06/2022', 149, null, 22211, '07/06/2022', 26 ) ;
INSERT INTO baixa_estoque VALUES (52, '08/06/2022', 150, null, 22211, '08/06/2022', 39 ) ;
INSERT INTO baixa_estoque VALUES (53, '09/06/2022', 151, null, 22211, '09/06/2022', 44 ) ;
INSERT INTO baixa_estoque VALUES (54, '10/06/2022', 152, null, 22211, '10/06/2022', 15 ) ;
INSERT INTO baixa_estoque VALUES (55, '12/06/2022', 153, null, 22211, '11/06/2022', 26 ) ;
INSERT INTO baixa_estoque VALUES (56, '12/06/2022', 154, null, 22211, '12/06/2022', 22 ) ;
INSERT INTO baixa_estoque VALUES (57, '13/06/2022', 155, null, 22211, '12/06/2022', 37 ) ;
INSERT INTO baixa_estoque VALUES (58, '14/06/2022', 156, null, 22211, '13/06/2022', 36 ) ;
INSERT INTO baixa_estoque VALUES (59, '14/06/2022', 157, null, 22211, '13/06/2022', 39 ) ;
INSERT INTO baixa_estoque VALUES (60, '14/06/2022', 158, null, 22211, '13/06/2022', 32 ) ;
INSERT INTO baixa_estoque VALUES (61, '14/06/2022', 159, null, 22211, '14/06/2022', 48 ) ;
INSERT INTO baixa_estoque VALUES (62, '15/06/2022', 160, null, 22211, '15/06/2022', 49 ) ;
INSERT INTO baixa_estoque VALUES (63, '16/06/2022', 161, null, 22211, '16/06/2022', 31 ) ;
INSERT INTO baixa_estoque VALUES (64, '17/06/2022', 162, null, 22211, '16/06/2022', 32 ) ;
INSERT INTO baixa_estoque VALUES (65, '17/06/2022', 163, null, 22211, '17/06/2022', 10 ) ;
INSERT INTO baixa_estoque VALUES (66, '18/06/2022', 164, null, 22211, '18/06/2022', 11 ) ;
INSERT INTO baixa_estoque VALUES (67, '18/06/2022', 165, null, 22211, '18/06/2022', 12 ) ;
INSERT INTO baixa_estoque VALUES (68, '20/06/2022', 166, null, 22211, '19/06/2022', 17 ) ;
INSERT INTO baixa_estoque VALUES (69, '20/06/2022', 167, null, 22211, '19/06/2022', 20 ) ;

--- SELECTS:

SELECT * FROM pedido	
SELECT * FROM medicamento
SELECT * FROM cliente
SELECT * FROM baixa_estoque


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

--SELECTS ADICIONAIS

-- Clientes que possuem cadastro, mas que não realizaram nenhuma compra (atração de clientes) - vendas

SELECT cl.codigo_cliente, cd.tipo_pedido, cl.sexo
FROM cliente cl LEFT OUTER JOIN pedido cd
ON (cl.codigo_cliente = cd.numero_pedido)
GROUP BY cl.codigo_cliente, cd.tipo_pedido, cl.sexo ;

-- Quais medicamentos tiveram saída nos últimos 30 dias - vendas

SELECT TO_CHAR(dt.data_saida, 'DD/MM/YYYY') AS "Data de saída medicamento", nm.nome_medicamento AS "Nome medicamento"
FROM baixa_estoque dt JOIN medicamento nm
ON (dt.codigo_medicamento = nm.codigo_medicamento)
WHERE data_saida >= current_date - INTERVAL '30' DAY
ORDER BY nm.nome_medicamento DESC ;