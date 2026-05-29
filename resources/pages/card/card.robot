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
    