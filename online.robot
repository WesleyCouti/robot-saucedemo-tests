*** Settings ***
Documentation        Cenarios de testse do Sistema de vendas
Library              Browser
Library              FakerLibrary
Library              String

*** Variables ***
${URL}               https://www.saucedemo.com/
${SENHA}             secret_sauce

*** Keywords ***
Abrir Aplicacao
    New Browser     browser=chromium    headless=False
    New Page        ${URL}
    Get Text        text=Swag Labs

Login
    [Arguments]    ${usuario}
    Fill Text       data-test=username    ${usuario}
    Fill Text       data-test=password    ${SENHA}
    Click           data-test=login-button

Validar_E_Adicionar_Produto
    [Arguments]    ${nome_produto}    ${preco_produto}    ${add_btn}
    ${txt}=    Get Text    xpath=//div[text()="${nome_produto}"]
    Should Be Equal    ${txt}    ${nome_produto}
    Wait For Elements State    xpath=//div[@class="inventory_item"][.//div[text()="${nome_produto}"]]//div[@class="inventory_item_price"]    visible    5
    ${preco}=    Get Text    xpath=//div[@class="inventory_item"][.//div[text()="${nome_produto}"]]//div[@class="inventory_item_price"]
    Should Be Equal    ${preco}    ${preco_produto}
    Click    css=[data-test="${add_btn}"]

Finalizar_Compra
    [Arguments]    ${nome}    ${sobrenome}    ${cep}
    Click        css=[data-test="checkout"]
    Fill Text    css=[data-test="firstName"]    ${nome}
    Fill Text    css=[data-test="lastName"]     ${sobrenome}
    Fill Text    css=[data-test="postalCode"]   ${cep}
    Click        css=[data-test="continue"]
    Click        css=[data-test="finish"]

Remover_Produto
    [Arguments]    ${remove_btn}
    Click    css=[data-test="${remove_btn}"]

Acessar_Carrinho
    Click    css=[data-test="shopping-cart-link"]

Validar_Produto_No_Carrinho
    [Arguments]    ${nome_produto}
    Wait For Elements State    css=[data-test="inventory-item-name"]    visible    5
    ${produto}=    Get Text    xpath=//div[@class="inventory_item_name" and text()="${nome_produto}"]
    Should Be Equal    ${produto}    ${nome_produto}

Gerar_Dados_Fake
    ${nome}=        FakerLibrary.FirstName
    ${sobrenome}=   FakerLibrary.LastName
    ${cep}=         Generate Random String    8    [NUMBERS]
    [Return]        ${nome}    ${sobrenome}    ${cep}

*** Test Cases ***
Compra com adicao e remocao de produtos usuario standard_user
    ${nome}    ${sobrenome}    ${cep}=    Gerar_Dados_Fake
    Abrir Aplicacao
    Login    standard_user
    Validar_E_Adicionar_Produto    Sauce Labs Bike Light    $9.99    add-to-cart-sauce-labs-bike-light
    Validar_E_Adicionar_Produto    Sauce Labs Fleece Jacket    $49.99    add-to-cart-sauce-labs-fleece-jacket
    Remover_Produto    remove-sauce-labs-bike-light
    Acessar_Carrinho
    Validar_Produto_No_Carrinho    Sauce Labs Fleece Jacket
    Finalizar_Compra    ${nome}    ${sobrenome}    ${cep}

Compra com adicao e remocao de produtos usuario performance_glitch_user
    ${nome}    ${sobrenome}    ${cep}=    Gerar_Dados_Fake
    Abrir Aplicacao
    Login    performance_glitch_user
    Validar_E_Adicionar_Produto    Sauce Labs Bike Light    $9.99    add-to-cart-sauce-labs-bike-light
    Validar_E_Adicionar_Produto    Sauce Labs Fleece Jacket    $49.99    add-to-cart-sauce-labs-fleece-jacket
    Remover_Produto    remove-sauce-labs-bike-light
    Acessar_Carrinho
    Validar_Produto_No_Carrinho    Sauce Labs Fleece Jacket
    Finalizar_Compra    ${nome}    ${sobrenome}    ${cep}

Compra com adicao e remocao de produtos usuario standard_user
    ${nome}    ${sobrenome}    ${cep}=    Gerar_Dados_Fake
    Abrir Aplicacao
    Login    standard_user
    Acessar_Carrinho
    Click    css=[data-test="checkout"]
    Fill Text    css=[data-test="firstName"]    ${nome}
    Fill Text    css=[data-test="lastName"]     ${sobrenome} 
    Fill Text    css=[data-test="postalCode"]   ${cep} 
    Click        css=[data-test="continue"]
    Click        css=[data-test="finish"]
