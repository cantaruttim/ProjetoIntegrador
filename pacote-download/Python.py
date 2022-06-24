import datetime
import PySimpleGUI as sg
import psycopg2

host = 'localhost'
# nome da base de dados
bdname = 'projeto_integrador'
# usuario, padrao e postgres
user = 'postgres'
password = 'Luscarosa8!'
sslmode = 'disable'

conn_string = f'host = {host} user = {user} dbname = {bdname} password = {password} sslmode = {sslmode}'
conn = psycopg2.connect(conn_string)


def convert (data):
    select = [['nome do medicamento', 'data de validade ', 'data de fabricacao', 'valor base', 'data de entrada',
               'quantidade em estoque', 'preco', 'classificacao do produto', 'apresentacao', 'tarja',
               'codigo do medicamento']]
    for i in range(len(data)):
        add = list(data[i])
        select.append(add)
    return select



def menu():
    sg.theme('DarkAmber')
    layout = [
        [sg.Text('Seja bem vindo!')],
        [sg.Button('cadastrar'), sg.Button('consultar')]
    ]
    return sg.Window('menu', layout=layout, finalize=True, size = (300,300))


def cadastrar():
    sg.theme('DarkAmber')
    layout = [
        [sg.Text('Digite o nome do medicamento')],
        [sg.Input(key='nome do medicamento')],
        [sg.Text('Digite a data de validade')],
        [sg.Input(key='data de validade')],
        [sg.Text('Digite a data de fabricação ')],
        [sg.Input(key='data de fabricacao')],
        [sg.Text('Digite o valor base')],
        [sg.Input(key='valor base')],
        [sg.Text('Digite a data de entrada')],
        [sg.Input(key='data de entrada')],
        [sg.Text('Digite a quantidade em estoque')],
        [sg.Input(key='quantidade em estoque')],
        [sg.Text('Digite o preço')],
        [sg.Input(key='preco')],
        [sg.Text('Digite a classificação do produto')],
        [sg.Input(key='classificacao do produto')],
        [sg.Text('Digite a apresentação')],
        [sg.Input(key='apresentacao')],
        [sg.Text('Digite a tarja')],
        [sg.Input(key='tarja')],
        [sg.Text('Digite o código do medicamento')],
        [sg.Input(key='codigo do medicamento')],
        [sg.Button('done'), sg.Button('voltar')],

        ]
    return sg.Window('cadastrar', layout=layout, finalize=True, size = (300,700))


def consulta():
    sg.theme('DarkAmber')
    layout = [
        [sg.Text('Digite a consulta em sql')],
        [sg.Input(key = 'sql')],
        [sg.Button('pesquisar')]
    ]
    return sg.Window('consulta', layout=layout, finalize=True, size=(300, 300))

def table(data):
    sg.theme('DarkAmber')
    layout = [[sg.Table(values=data[1:][:], headings=data[0],
                        auto_size_columns=True,
                        # cols_justification=('left','center','right','c', 'l', 'bad'),       # Added on GitHub only as of June 2022

                        justification='center',
                        num_rows=3,
                        alternating_row_color='lightblue',
                        key='-TABLE-',
                        selected_row_colors='red on yellow',
                        enable_events=True,
                        expand_x=False,
                        expand_y=True,
                        vertical_scroll_only=False,
                        enable_click_events=True,  # Comment out to not enable header and other clicks
                        tooltip='This is a table')],
              [sg.Button('menu')]

              ]

    return sg.Window('consulta', layout=layout, finalize=True, size=(300, 300))



janela_menu, janela_cadastro, janela_consulta, janela_table = menu(), None, None, None
all_janelas = [janela_menu, janela_cadastro, janela_consulta]

while True:
    all_janelas = [janela_menu, janela_cadastro, janela_consulta]
    cursor = conn.cursor()
    window, event, values = sg.read_all_windows()
    if window in all_janelas and event == sg.WINDOW_CLOSED:
        break
    if window == janela_menu and event == 'cadastrar':
        janela_cadastro = cadastrar()
        janela_menu.hide()
        janela_cadastro.un_hide()


    if window == janela_cadastro and event == 'done':
        sg.Popup(values['nome do medicamento'], values['data de validade'], values['data de fabricacao'], values ['valor base'], values['data de entrada'], values ['quantidade em estoque'], values ['preco'], values ['classificacao do produto'], values ['apresentacao'], values ['tarja'], values ['codigo do medicamento'])
        cursor.execute(
            f"insert into medicamento values ('{values['nome do medicamento']}', '{values['data de validade']}' , '{values['data de fabricacao']}', '{values['valor base']}', '{values['data de entrada']}', '{values['quantidade em estoque']}', '{values['preco']}', '{values['classificacao do produto']}', '{values['apresentacao']}', '{values['tarja']}', '{values['codigo do medicamento']}'); ")
        conn.commit()


    if window == janela_cadastro and event == 'voltar':
        janela_cadastro.hide()
        janela_menu.un_hide()

    if window == janela_menu and event == 'consultar':
        janela_consulta = consulta()
        janela_menu.hide()
        janela_consulta.un_hide()



    if window == janela_consulta and event == 'pesquisar':
        cursor.execute(f" {values['sql']}")
        sql  = cursor.fetchall()
        consulta = convert(sql)
        conn.commit()
        janela_table = table(consulta)
        janela_consulta.hide()
        janela_table.un_hide()


    if window == janela_table and event == 'menu':
        janela_table.hide()
        janela_menu.un_hide()



conn.commit()
cursor.close()
conn.close()
