*** Settings ***
Library    SeleniumLibrary
Library    Collections
Resource      ../../../variables/variables.robot

Resource      ../../../resources/pages/browser/browser_setup.robot
Resource      ../../../resources/pages/login/login_page.robot
Resource     ../../../resources/pages/home/home_page.robot
Resource     ../../../resources/pages/cart/cart.robot
Resource     ../../../resources/pages/checkout/checkout.robot
Resource     ../../../resources/pages/card/card.robot

*** Test Cases ***
Validar carrinho
    [Tags]    smoke5    login
    Abrir Chrome Configurado        ${SAUCE_URL}
    Fazer Login E Aguardar Home    
    Clicar em adicionar item ao carrinho
    Validar botao remover produto do carrinho na tela de home
    Validar icone vermelho indicando que ha item no carrinho
    Clicar no carrinho
    Fechar Navegador

Validar checkout sem informacao
    [Tags]    smoke5    login
    Abrir Chrome Configurado        ${SAUCE_URL}
    Fazer Login E Aguardar Home    
    Clicar em adicionar item ao carrinho
    Validar botao remover produto do carrinho na tela de home
    Validar icone vermelho indicando que ha item no carrinho
    Clicar no carrinho
    Clicar em checkout
    Clicar em continue
    Validar que mensagem de erro dados nao preenchidos foi exibida
    Fechar Navegador

Validar compra de produto
    [Tags]    smoke5    login
    Abrir Chrome Configurado        ${SAUCE_URL}
    Fazer Login E Aguardar Home    
    Clicar em adicionar item ao carrinho
    Validar botao remover produto do carrinho na tela de home
    Validar icone vermelho indicando que ha item no carrinho
    Clicar no carrinho
    Clicar em checkout
    Inserir dados pro checkout
    Clicar em continue 
    Clicar em finish
    Validar tela de sucesso na compra de um produto
    Fechar Navegador


Validar cancelar compra de produto
    [Tags]    smoke5    login
    Abrir Chrome Configurado        ${SAUCE_URL}
    Fazer Login E Aguardar Home    
    Clicar em adicionar item ao carrinho
    Validar botao remover produto do carrinho na tela de home
    Validar icone vermelho indicando que ha item no carrinho
    Clicar no carrinho
    Clicar em checkout
    Inserir dados pro checkout
    Clicar em continue
    Clicar em cancelar compra    
    Validar homepage com listagem de produtos
    Fechar Navegador