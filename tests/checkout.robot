*** Settings ***
Documentation       Cenários de checkout no SauceDemo

Resource            ../resources/common_keywords.robot
Resource            ../resources/cart_keywords.robot
Resource            ../resources/checkout_keywords.robot

Test Setup          Abrir Aplicacao
Test Teardown       Fechar Aplicacao


*** Test Cases ***
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