*** Settings ***
Library    SeleniumLibrary
Library    Collections
Resource      ../../variables/variables.robot
Resource      ../../resources/pages/browser/browser_setup.robot
Resource      ../../resources/pages/login/login_page.robot
Resource      ../../resources/pages/home/home_page.robot
Resource      ../../resources/pages/cart/cart.robot
Resource      ../../resources/pages/checkout/checkout.robot
Resource      ../../resources/pages/card/card.robot

*** Test Cases ***
Validar Card de produto na home
    Abrir Chrome Configurado        ${SAUCE_URL}
    Fazer Login E Aguardar Home  
    Validar dados do card 
    Fechar Navegador

Validar adicionar produto ao carrinho
    Abrir Chrome Configurado        ${SAUCE_URL}
    Fazer Login E Aguardar Home
    Clicar em adicionar item ao carrinho
    Validar botao remover produto do carrinho na tela de home
    Validar icone vermelho indicando que ha item no carrinho    
    Fechar Navegador

Validar remover produto do carrinho
    Abrir Chrome Configurado        ${SAUCE_URL}
    Fazer Login E Aguardar Home    
    Clicar em adicionar item ao carrinho    
    Validar icone vermelho indicando que ha item no carrinho
    Validar botao remover produto do carrinho na tela de home
    Clicar em remover item do carrinho
    Fechar Navegador
