*** Settings ***
Library    SeleniumLibrary
Library    Collections
Resource      ../../../variables/variables.robot

*** Variables ***
${URL}    https://www.saucedemo.com/

*** Test Cases ***
Validar carrinho

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

    
    Element Should Be Visible    id:add-to-cart-sauce-labs-backpack
    Click Button    id:add-to-cart-sauce-labs-backpack
    Element Should Be Visible    id:remove-sauce-labs-backpack
    Element Should Be Visible    class:shopping_cart_badge
    
    Sleep    3s   

    Click Element    class:shopping_cart_link
    Element Text Should Be    class:title    Your Cart
    Close Browser


Validar checkout sem informacao

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

    
    Element Should Be Visible    id:add-to-cart-sauce-labs-backpack
    Click Button    id:add-to-cart-sauce-labs-backpack
    Element Should Be Visible    id:remove-sauce-labs-backpack
    Element Should Be Visible    class:shopping_cart_badge
    
    Sleep    3s   

    Click Element    class:shopping_cart_link
    Click Button    id:checkout 
    Click Button    id:continue
    Element Should Be Visible    class:error-button

    Wait Until Element Is Visible    class:error-message-container    10s
    Page Should Contain Element    css:h3[data-test="error"]
    ${mensagem}=    Get Text    css:h3[data-test="error"]
    Should Be Equal
...    ${mensagem}
...    Error: First Name is required

    Close Browser

Validar compra de produto

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

    
    Element Should Be Visible    id:add-to-cart-sauce-labs-backpack
    Click Button    id:add-to-cart-sauce-labs-backpack
    Element Should Be Visible    id:remove-sauce-labs-backpack
    Element Should Be Visible    class:shopping_cart_badge
    
    Sleep    3s   

    Click Element    class:shopping_cart_link
    Click Button    id:checkout 

    Input Text    id:first-name    ${FIRST_NAME}
    Input Text    id:last-name    ${LAST_NAME}
    Input Text    id:postal-code    ${POSTAL_CODE}

    Click Button    id:continue
    Click Button    id:finish

    Element Should Be Visible    class:pony_express
    Element Should Be Visible    class:complete-header
    Element Should Be Visible    class:complete-text
    Element Should Be Visible    id:back-to-products

    
    Page Should Contain Element    css:h2[data-test="complete-header"]
    ${mensagem}=    Get Text    css:h2[data-test="complete-header"]
    Should Be Equal
...    ${mensagem}
...    Thank you for your order!
    
      Page Should Contain Element    css:div[data-test="complete-text"]
    ${mensagem}=    Get Text    css:div[data-test="complete-text"]
    Should Be Equal
...    ${mensagem}
...    Your order has been dispatched, and will arrive just as fast as the pony can get there!
    Close Browser


Validar cancelar compra de produto

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

    
    Element Should Be Visible    id:add-to-cart-sauce-labs-backpack
    Click Button    id:add-to-cart-sauce-labs-backpack
    Element Should Be Visible    id:remove-sauce-labs-backpack
    Element Should Be Visible    class:shopping_cart_badge
    
    Sleep    3s   

    Click Element    class:shopping_cart_link
    Click Button    id:checkout 

    Input Text    id:first-name    ${FIRST_NAME}
    Input Text    id:last-name    ${LAST_NAME}
    Input Text    id:postal-code    ${POSTAL_CODE}

    Click Button    id:continue
    Click Button    id:cancel
    Element Text Should Be    class:title    Products
    Close Browser