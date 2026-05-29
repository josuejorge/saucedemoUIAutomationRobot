*** Settings ***
Library    SeleniumLibrary

*** Keywords ***
Abrir Chrome Configurado
    [Arguments]    ${url}
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
    Call Method    ${options}    add_argument    --incognito
    Call Method    ${options}    add_argument    --disable-notifications
    ${prefs}=    Create Dictionary
    ...    credentials_enable_service=${False}
    ...    profile.password_manager_enabled=${False}
    Call Method    ${options}    add_experimental_option    prefs    ${prefs}
    Open Browser    ${url}    chrome    options=${options}
    Maximize Browser Window

Fechar Navegador
    Close Browser