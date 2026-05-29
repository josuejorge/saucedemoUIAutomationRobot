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

Validar Remover pedido do carrinho
    Click Button    id:remove-sauce-labs-backpack

Validar que pedido foi excluido do carrinho
    Element Should Not Be Visible    id:remove-sauce-labs-backpack

