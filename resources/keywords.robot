*** Settings ***
Library             Browser
Library             FakerLibrary
Library             String

Resource            variables.robot


*** Keywords ***
Abrir Aplicacao
    New Browser    browser=${BROWSER}    headless=${HEADLESS}
    New Page       ${URL}
    Get Text       text=Swag Labs

Fechar Aplicacao
    Close Browser

Login
    [Arguments]    ${usuario}

    Fill Text    css=[data-test="username"]    ${usuario}
    Fill Text    css=[data-test="password"]    ${SENHA}
    Click        css=[data-test="login-button"]

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

Preencher Dados Do Checkout
    [Arguments]    ${nome}    ${sobrenome}    ${cep}

    Fill Text    css=[data-test="firstName"]     ${nome}
    Fill Text    css=[data-test="lastName"]      ${sobrenome}
    Fill Text    css=[data-test="postalCode"]    ${cep}

Finalizar Compra
    [Arguments]    ${nome}    ${sobrenome}    ${cep}

    Click    css=[data-test="checkout"]

    Preencher Dados Do Checkout
    ...    ${nome}
    ...    ${sobrenome}
    ...    ${cep}

    Click    css=[data-test="continue"]
    Click    css=[data-test="finish"]

    ${mensagem}=    Get Text    css=[data-test="complete-header"]
    Should Be Equal    ${mensagem}    Thank you for your order!

Finalizar Checkout Sem Produtos
    [Arguments]    ${nome}    ${sobrenome}    ${cep}

    Click    css=[data-test="checkout"]

    Preencher Dados Do Checkout
    ...    ${nome}
    ...    ${sobrenome}
    ...    ${cep}

    Click    css=[data-test="continue"]
    Click    css=[data-test="finish"]

Gerar Dados Fake
    ${nome}=         FakerLibrary.FirstName
    ${sobrenome}=    FakerLibrary.LastName
    ${cep}=          Generate Random String    8    [NUMBERS]

    RETURN    ${nome}    ${sobrenome}    ${cep}