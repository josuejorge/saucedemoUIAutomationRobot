*** Settings ***
Library    SeleniumLibrary
Resource      ../../variables/variables.robot

*** Test Cases ***

Validar que site abriu com sucesso
    Open Browser    ${URL}    chrome
    Sleep    3s
    Wait Until Element Is Visible    class:login_logo    10s
    Element Text Should Be    class:login_logo    Swag Labs
    Close Browser

Validar Login Com Sucesso
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window

    Input Text    id:user-name    ${USER}
    Input Password    id:password    ${PASSWORD}

    Click Button    id:login-button
    Wait Until Element Is Visible    class:title    10s
    Element Text Should Be    class:title    Products
    Sleep    3s
    Close Browser

Validar Login Com Falha
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window

    Input Text    id:user-name    ${USER}
    Input Password    id:password    ${PASSWORDWRONG}
    
    Click Button    id:login-button
    Wait Until Element Is Visible    class:error-message-container    10s
    Page Should Contain Element    css:h3[data-test="error"]
    ${mensagem}=    Get Text    css:h3[data-test="error"]
    Should Be Equal
...    ${mensagem}
...    Epic sadface: Username and password do not match any user in this service

    
    Sleep    3s
    Close Browser