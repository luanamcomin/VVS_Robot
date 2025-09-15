*** Settings ***
Library     SeleniumLibrary
Library     String
Resource    ../variables/variables.robot

*** Variables ***
${GENERATED_EMAIL}    ${EMPTY}

*** Keywords ***
Abrir Navegador e Acessar o site
    [Documentation]    Abre o navegador e acessa o site do Demo Web Shop
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Set Browser Implicit Wait    10s

Clicar em Register
    [Documentation]    Clica no link de registro no cabeçalho
    Click Link    ${REGISTER_LINK}
    Page Should Contain    Register

Preencher Formulário de Registro
    [Documentation]    Preenche o formulário de registro com os dados do usuário
    [Arguments]    ${first_name}=${FIRST_NAME}    ${last_name}=${LAST_NAME}    ${email}=${EMAIL}    ${password}=${PASSWORD}
    
    # Gera um e-mail único para cada teste
    ${random_string}=    Generate Random String    5    [LETTERS][NUMBERS]
    ${generated_email}=    Set Variable    ${email.replace("@", "${random_string}@")}
    Set Suite Variable    ${GENERATED_EMAIL}    ${generated_email}
    Log    Generated email: ${GENERATED_EMAIL}    level=INFO
    
    Select Radio Button    Gender    M
    Input Text    id=FirstName    ${first_name}
    Input Text    id=LastName    ${last_name}
    Input Text    id=Email    ${generated_email}
    Input Text    id=Password    ${password}
    Input Text    id=ConfirmPassword    ${password}
    Click Button    id=register-button

Verificar Registro Bem Sucedido
    [Documentation]    Verifica se o registro foi concluído com sucesso
    Wait Until Page Contains    Your registration completed
    Page Should Contain    Your registration completed

Clicar em Continuar
    [Documentation]    Clica no botão Continue após o registro bem-sucedido
    Click Button    xpath://input[contains(@class, 'register-continue-button')]
    Wait Until Page Contains    ${GENERATED_EMAIL}
