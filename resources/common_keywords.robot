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

Gerar Dados Fake
    ${nome}=         FakerLibrary.FirstName
    ${sobrenome}=    FakerLibrary.LastName
    ${cep}=          Generate Random String    8    [NUMBERS]

    RETURN    ${nome}    ${sobrenome}    ${cep}