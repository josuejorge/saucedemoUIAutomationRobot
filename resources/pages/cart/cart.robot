*** Settings ***
Library    SeleniumLibrary
Resource      ../../../variables/variables.robot


*** Keywords ***
Clicar no carrinho
    Click Element             class:shopping_cart_link
    Element Text Should Be    class:title    Your Cart

Clicar em checkout
    Click Button    id:checkout 

Clicar em continue
    Click Button    id:continue
