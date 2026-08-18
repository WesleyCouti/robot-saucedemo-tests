*** Settings ***
Library             Browser


*** Keywords ***
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

Validar Erro No Checkout
    [Arguments]    ${mensagem_esperada}

    ${mensagem}=    Get Text    css=[data-test="error"]
    Should Contain    ${mensagem}    ${mensagem_esperada}