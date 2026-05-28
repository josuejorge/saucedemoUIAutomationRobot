*** Settings ***
Library    SeleniumLibrary
Library    Collections
Resource      ../../variables/variables.robot

*** Variables ***
${URL}    https://www.saucedemo.com/

*** Test Cases ***
Validar Homepage

    ${chrome_options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys

    Call Method    ${chrome_options}    add_argument    --incognito
    Call Method    ${chrome_options}    add_argument    --disable-notifications

    ${prefs}=    Create Dictionary
    ...    credentials_enable_service=${False}
    ...    profile.password_manager_enabled=${False}

    Call Method
    ...    ${chrome_options}
    ...    add_experimental_option
    ...    prefs
    ...    ${prefs}

    Open Browser
    ...    ${URL}
    ...    chrome
    ...    options=${chrome_options}

    Maximize Browser Window
    Input Text    id:user-name    ${USER}
    Input Password    id:password    ${PASSWORD}

    Click Button    id:login-button
    Wait Until Element Is Visible    class:title    10s
    Element Text Should Be    class:title    Products
    Sleep    3s    

    Close Browser