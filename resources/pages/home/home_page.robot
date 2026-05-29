*** Settings ***
Library    SeleniumLibrary

*** Keywords ***
Validar Card De Produto Visivel
    Element Should Be Visible      class:inventory_item_name
    Element Should Be Visible      class:inventory_item_desc
    Page Should Contain Element    class:inventory_item_price
    Page Should Contain Element    class:inventory_item_img

Validar Botao Adicionar Ao Carrinho Visivel
    [Arguments]    ${produto_id}=add-to-cart-sauce-labs-backpack
    Element Should Be Visible    id:${produto_id}

Clicar no menu hamburguer
    Click Button    id:react-burger-menu-btn
    Sleep    3s
    
Clicar em logout
    Click Element    id:logout_sidebar_link
    Sleep    3s

Validar botao remover produto do carrinho na tela de home
    Element Should Be Visible    id:remove-sauce-labs-backpack

Validar icone vermelho indicando que ha item no carrinho
    Element Should Be Visible    class:shopping_cart_badge

Clicar em adicionar item ao carrinho
    Element Should Be Visible    id:add-to-cart-sauce-labs-backpack    
    Click Button    id:add-to-cart-sauce-labs-backpack

Clicar em remover item do carrinho
    Element Should Be Visible    id:remove-sauce-labs-backpack    
    Click Button    id:remove-sauce-labs-backpack

Validar homepage com listagem de produtos
    Element Text Should Be    class:title    Products
    