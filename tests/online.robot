*** Settings ***
Documentation       Testes automatizados do fluxo de compra no SauceDemo

Resource            ../resources/keywords.robot

Test Setup          Abrir Aplicacao
Test Teardown       Fechar Aplicacao


*** Test Cases ***
Compra Com Usuario Standard
    [Tags]    smoke    regression

    ${nome}    ${sobrenome}    ${cep}=    Gerar Dados Fake

    Login    standard_user

    Validar E Adicionar Produto
    ...    Sauce Labs Bike Light
    ...    $9.99
    ...    add-to-cart-sauce-labs-bike-light

    Validar E Adicionar Produto
    ...    Sauce Labs Fleece Jacket
    ...    $49.99
    ...    add-to-cart-sauce-labs-fleece-jacket

    Remover Produto    remove-sauce-labs-bike-light

    Acessar Carrinho
    Validar Produto No Carrinho    Sauce Labs Fleece Jacket

    Finalizar Compra    ${nome}    ${sobrenome}    ${cep}


Compra Com Usuario Performance Glitch
    [Tags]    regression

    ${nome}    ${sobrenome}    ${cep}=    Gerar Dados Fake

    Login    performance_glitch_user

    Validar E Adicionar Produto
    ...    Sauce Labs Bike Light
    ...    $9.99
    ...    add-to-cart-sauce-labs-bike-light

    Validar E Adicionar Produto
    ...    Sauce Labs Fleece Jacket
    ...    $49.99
    ...    add-to-cart-sauce-labs-fleece-jacket

    Remover Produto    remove-sauce-labs-bike-light

    Acessar Carrinho
    Validar Produto No Carrinho    Sauce Labs Fleece Jacket

    Finalizar Compra    ${nome}    ${sobrenome}    ${cep}


Checkout Sem Preencher Dados Obrigatorios
    [Tags]    negative    regression

    Login    standard_user

    Validar E Adicionar Produto
    ...    Sauce Labs Backpack
    ...    $29.99
    ...    add-to-cart-sauce-labs-backpack

    Acessar Carrinho

    Click    css=[data-test="checkout"]
    Click    css=[data-test="continue"]

    Validar Erro No Checkout
    ...    Error: First Name is required