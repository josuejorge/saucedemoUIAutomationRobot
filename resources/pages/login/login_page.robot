*** Settings ***
Library    SeleniumLibrary
Resource   ../../variables/variables.robot

*** Keywords ***
Validar tela de login
    Wait Until Element Is Visible    class:login_logo    10s
    Element Text Should Be           class:login_logo    Swag Labs
    
Fazer Login
    [Arguments]    ${usuario}=${SAUCE_USER}    ${senha}=${SAUCE_PASSWORD}
    Input Text        id:user-name    ${usuario}
    Input Password    id:password     ${senha}
    Click Button      id:login-button


Fazer Login com
    [Arguments]    ${usuario}    ${senha}
    Input Text        id:user-name    ${usuario}
    Input Password    id:password     ${senha}
    Click Button      id:login-button

Fazer Login E Aguardar Home
    Fazer Login
    Wait Until Element Is Visible    class:title    10s
    Element Text Should Be           class:title    Products

Clicar em fazer login
    Click Button    id:login-button

Validar mensagem de erro de usuario requerido
    Wait Until Element Is Visible    class:error-message-container    10s
    Page Should Contain Element    css:h3[data-test="error"]
    ${mensagem}=    Get Text    css:h3[data-test="error"]
    Should Be Equal
...    ${mensagem}
...    Epic sadface: Username is required

Validar mensagem de erro de usuario e ou senha errados
    Wait Until Element Is Visible    class:error-message-container    10s
    Page Should Contain Element    css:h3[data-test="error"]
    ${mensagem}=    Get Text    css:h3[data-test="error"]
    Should Be Equal
...    ${mensagem}
...    Epic sadface: Username and password do not match any user in this service    
    Sleep    3s

Inserir usuario e senha errado
    Input Text    id:user-name    ${SAUCE_USER}
    Input Password    id:password    ${SAUCE_PASSWORDWRONG}


Validar mensagem de erro de usuario bloqueado
    Wait Until Element Is Visible    class:error-message-container    10s
    Page Should Contain Element    css:h3[data-test="error"]
    ${mensagem}=    Get Text    css:h3[data-test="error"]
    Should Be Equal
...    ${mensagem}
...    Epic sadface: Sorry, this user has been locked out.    
    Sleep    3s
