*** Settings ***
Library    SeleniumLibrary
Resource      ../../../variables/variables.robot

*** Keywords ***
Validar dados do card
    Element Should Be Visible    class:inventory_item_name
    Element Should Be Visible    class:inventory_item_desc

    Page Should Contain Element    class:inventory_item_price
    Element Should Be Visible    id:add-to-cart-sauce-labs-backpack
    Page Should Contain Element    class:inventory_item_img
    
Clicar em back to products
    Click Button    id:back-to-products

Clicar em detalhes do produto
    Click Element    class:inventory_item_name 

Validar tela de detalhes do produto
    Page Should Contain Element    class:inventory_details_name
    Element Should Be Visible      class:inventory_details_desc
    Page Should Contain Element    class:inventory_details_price 
    Element Should Be Visible      id:add-to-cart
    Page Should Contain Element    class:inventory_details_img
    
Clicar em adicionar ao carrinho pela tela de detalhes
    Element Should Be Visible    id:add-to-cart
    Click Button                 id:add-to-cart
