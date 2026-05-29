*** Settings ***
Library    SeleniumLibrary
Resource      ../../../variables/variables.robot


*** Keywords ***
Clicar em finish
    Click Button    id:finish 

Validar que mensagem de erro dados nao preenchidos foi exibida
    Element Should Be Visible    class:error-button
    Wait Until Element Is Visible    class:error-message-container    10s
    Page Should Contain Element    css:h3[data-test="error"]
    ${mensagem}=    Get Text    css:h3[data-test="error"]
    Should Be Equal
...    ${mensagem}
...    Error: First Name is required

Inserir dados pro checkout 
    Input Text    id:first-name    ${FIRST_NAME}
    Input Text    id:last-name    ${LAST_NAME}
    Input Text    id:postal-code    ${POSTAL_CODE}

Validar tela de sucesso na compra de um produto
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

Clicar em cancelar compra
    Click Button    id:cancel
    