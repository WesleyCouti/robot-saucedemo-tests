*** Settings ***
Documentation       Cenários de carrinho no SauceDemo

Resource            ../resources/common_keywords.robot
Resource            ../resources/cart_keywords.robot
Resource            ../resources/checkout_keywords.robot

Test Setup          Abrir Aplicacao
Test Teardown       Fechar Aplicacao


*** Keywords ***
Validar E Adicionar Produto
    [Arguments]    ${nome_produto}    ${preco_produto}    ${botao_adicionar}

    ${produto}=    Get Text    xpath=//div[text()="${nome_produto}"]
    Should Be Equal    ${produto}    ${nome_produto}

    ${seletor_preco}=    Set Variable
    ...    xpath=//div[@class="inventory_item"][.//div[text()="${nome_produto}"]]//div[@class="inventory_item_price"]

    Wait For Elements State    ${seletor_preco}    visible    5

    ${preco}=    Get Text    ${seletor_preco}
    Should Be Equal    ${preco}    ${preco_produto}

    Click    css=[data-test="${botao_adicionar}"]

Remover Produto
    [Arguments]    ${botao_remover}

    Click    css=[data-test="${botao_remover}"]

Acessar Carrinho
    Click    css=[data-test="shopping-cart-link"]
    Wait For Elements State    css=[data-test="checkout"]    visible    5

Validar Produto No Carrinho
    [Arguments]    ${nome_produto}

    Wait For Elements State
    ...    css=[data-test="inventory-item-name"]
    ...    visible
    ...    5

    ${produto}=    Get Text
    ...    xpath=//div[@class="inventory_item_name" and text()="${nome_produto}"]

    Should Be Equal    ${produto}    ${nome_produto}