*** Settings ***
Library    SeleniumLibrary
Library    Collections
Resource      ../../variables/variables.robot

*** Variables ***
${URL}    https://www.saucedemo.com/

*** Test Cases ***
Validar Card de produto na home

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
    Input Text    id:user-name    ${SAUCE_USER}
    Input Password    id:password    ${SAUCE_PASSWORD}

    Click Button    id:login-button
    Wait Until Element Is Visible    class:title    10s
    Element Text Should Be    class:title    Products

    Element Should Be Visible    class:inventory_item_name
    Element Should Be Visible    class:inventory_item_desc

    Page Should Contain Element    class:inventory_item_price
    Element Should Be Visible    id:add-to-cart-sauce-labs-backpack
    Page Should Contain Element    class:inventory_item_img
    
    Sleep    3s    

    Close Browser

Validar adicionar produto ao carrinho

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
    Input Text    id:user-name    ${SAUCE_USER}
    Input Password    id:password    ${SAUCE_PASSWORD}

    Click Button    id:login-button
    Wait Until Element Is Visible    class:title    10s
    Element Text Should Be    class:title    Products

    
    Element Should Be Visible    id:add-to-cart-sauce-labs-backpack
    Click Button    id:add-to-cart-sauce-labs-backpack
    Element Should Be Visible    id:remove-sauce-labs-backpack
    Element Should Be Visible    class:shopping_cart_badge
    
    Sleep    3s    

    Close Browser

Validar remover produto do carrinho

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
    Input Text    id:user-name    ${SAUCE_USER}
    Input Password    id:password    ${SAUCE_PASSWORD}

    Click Button    id:login-button
    Wait Until Element Is Visible    class:title    10s
    Element Text Should Be    class:title    Products
    
    Element Should Be Visible    id:add-to-cart-sauce-labs-backpack
    Click Button    id:add-to-cart-sauce-labs-backpack
    Element Should Be Visible    id:remove-sauce-labs-backpack
    Element Should Be Visible    class:shopping_cart_badge
    Click Button    id:remove-sauce-labs-backpack
    Element Should Not Be Visible    class:shopping_cart_badge    
    
    Sleep    3s    

    Close Browser