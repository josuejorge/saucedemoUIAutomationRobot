*** Settings ***
Library    SeleniumLibrary
Library    Collections

Resource      ../../variables/variables.robot
Resource     ../../resources/pages/browser/browser_setup.robot
Resource     ../../resources/pages/login/login_page.robot
Resource     ../../resources/pages/home/home_page.robot

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
    