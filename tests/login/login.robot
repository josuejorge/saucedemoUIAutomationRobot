*** Settings ***
Library    SeleniumLibrary
Resource      ../../variables/variables.robot
Resource      ../../resources/pages/browser/browser_setup.robot
Resource      ../../resources/pages/login/login_page.robot
Resource     ../../resources/pages/home/home_page.robot

*** Test Cases ***

Validar que site abriu com sucesso   
    [Tags]    smoke    login 
    Abrir Chrome Configurado        ${SAUCE_URL}
    Validar tela de login
    Fechar Navegador

Validar Login Com Sucesso
    [Tags]    smoke    login
    Abrir Chrome Configurado        ${SAUCE_URL}
    Fazer Login E Aguardar Home
    Fechar Navegador

Validar Login Com Falha
    [Tags]    smoke    login
    Abrir Chrome Configurado        ${SAUCE_URL}
    Inserir usuario e senha errado    
    Clicar em fazer login
    Validar mensagem de erro de usuario e ou senha errados
    Fechar Navegador

Validar Login Com Campos vazios
    [Tags]    smoke    login    
    Abrir Chrome Configurado        ${SAUCE_URL}    
    Clicar em fazer login
    Validar mensagem de erro de usuario requerido   
    Fechar Navegador

Validar Login Com usuario bloqueado
    [Tags]    smoke9    login    
    Abrir Chrome Configurado        ${SAUCE_URL} 
    Fazer Login com    locked_out_user    secret_sauce       
    Clicar em fazer login
    Validar mensagem de erro de usuario bloqueado   
    Fechar Navegador


Validar Logout
    [Tags]    smoke    login
    Abrir Chrome Configurado        ${SAUCE_URL}
    Fazer Login E Aguardar Home    
    Clicar no menu hamburguer
    Clicar em logout
    Validar tela de login
    Fechar Navegador

Validar abrir navegador
    [Tags]    smoke    login
    Abrir Chrome Configurado        ${SAUCE_URL}
    Fazer Login E Aguardar Home
    Fechar Navegador
