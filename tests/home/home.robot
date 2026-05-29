*** Settings ***
Library    SeleniumLibrary
Library    Collections

Resource      ../../variables/variables.robot
Resource     ../../resources/pages/browser/browser_setup.robot
Resource     ../../resources/pages/login/login_page.robot
Resource     ../../resources/pages/home/home_page.robot
Resource     ../../resources/pages/cart/cart.robot

*** Test Cases ***
Validar Homepage
    [Tags]    smoke2    login
    Abrir Chrome Configurado          ${SAUCE_URL}
    Fazer Login E Aguardar Home
    Fechar Navegador

Validar Card De Produto Na Home
    [Tags]    smoke2    login
    Abrir Chrome Configurado          ${SAUCE_URL}
    Fazer Login E Aguardar Home
    Validar Card De Produto Visivel
    Validar Botao Adicionar Ao Carrinho Visivel
    Fechar Navegador

Validar about
    [Tags]    smoke9    login
    Abrir Chrome Configurado          ${SAUCE_URL}
    Fazer Login E Aguardar Home
    Clicar no menu hamburguer
    Clicar em about
    Validar redirecionamento do botao about
    Fechar Navegador

Validar all items
    [Tags]    smoke9    login
    Abrir Chrome Configurado          ${SAUCE_URL}
    Fazer Login E Aguardar Home
    Clicar em adicionar item ao carrinho
    Clicar no carrinho
    Clicar no menu hamburguer
    Clicar em all items
    Fechar Navegador

Validar Carrinho persistido após reload na tela
    [Tags]    smoke9    login
    Abrir Chrome Configurado        ${SAUCE_URL}
    Fazer Login E Aguardar Home    
    Clicar em adicionar item ao carrinho
    Validar botao remover produto do carrinho na tela de home
    Validar icone vermelho indicando que ha item no carrinho
    Refresh na pagina
    Validar icone vermelho indicando que ha item no carrinho
    Fechar Navegador

Validar ordenar produtos Name (A to Z)
    [Tags]    smoke9    login
    Abrir Chrome Configurado        ${SAUCE_URL}
    Fazer Login E Aguardar Home
    Selecionar Ordenacao
...    Name (A to Z)
    Fechar Navegador


Validar ordenar produtos Name (Z to A)
    [Tags]    smoke9    login
    Abrir Chrome Configurado        ${SAUCE_URL}
    Fazer Login E Aguardar Home
    Selecionar Ordenacao
...    Name (Z to A)
    Fechar Navegador


Validar ordenar produtos Price (Low to High)
    [Tags]    smoke9    login
    Abrir Chrome Configurado        ${SAUCE_URL}
    Fazer Login E Aguardar Home
    Selecionar Ordenacao
...    Price (low to high)
    Fechar Navegador


Validar ordenar produtos Price (High to Low)
    [Tags]    smoke9    login
    Abrir Chrome Configurado        ${SAUCE_URL}
    Fazer Login E Aguardar Home
    Selecionar Ordenacao
...    Price (high to low)
    Fechar Navegador
    