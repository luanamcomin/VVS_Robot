*** Settings ***
Resource    ../variables/variables.robot
Resource    ../resources/common_resources.robot
Library     SeleniumLibrary

*** Keywords ***
Fazer Login
    [Documentation]    Realiza o login com as credenciais do usuário
    Log    Fazendo login com email: ${GENERATED_EMAIL}    level=INFO
    Click Link    ${LOGIN_LINK}
    Input Text    ${EMAIL_FIELD}    ${GENERATED_EMAIL}
    Input Text    ${PASSWORD_FIELD}    ${PASSWORD}
    Click Button    ${LOGIN_BUTTON}

Verificar Login Bem Sucedido
    [Documentation]    Verifica se o login foi realizado com sucesso
    Wait Until Page Contains Element    ${LOGOUT_LINK}
    Page Should Contain Link    ${LOGOUT_LINK}