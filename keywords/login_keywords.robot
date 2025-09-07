*** Settings ***
Library     SeleniumLibrary
Library     OperatingSystem
Library     Collections
Resource    ../variables/variables.robot

*** Keywords ***
Abrir Navegador e Acessar SAP
    Log    Abrindo navegador e acessando SAP Fiori
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method    ${options}    add_argument    --incognito
    Open Browser    ${URL}    ${BROWSER}    options=${options}
    Maximize Browser Window
    Set Browser Implicit Wait    10s

Fazer Login
    Log    Iniciando processo de login
    Input Text    id=USERNAME_FIELD-inner    ${USERNAME}
    Input Text    id=PASSWORD_FIELD-inner    ${PASSWORD}
    Click Button  id=LOGIN_LINK
    Fechar Abas Secundárias
    Verificar Login


Fechar Abas Secundárias
    Log    Fechando aba secundária aberta durante o login
    Wait Until Keyword Succeeds    10x    1s    Deve Ter Mais De Uma Aba

    # Fecha a aba mais recentemente aberta (geralmente a de login)
    Switch Window    NEW
    Close Window

    # Retorna para a aba principal (Home)
    Switch Window    MAIN

Deve Ter Mais De Uma Aba
    ${janelas}=    Get Window Handles
    ${quantidade}=    Evaluate    len(${janelas})
    IF    ${quantidade} <= 1
        Fail    Ainda há apenas uma aba aberta.
    END

Fechar Aba
    [Arguments]    ${handle}
    Log    Fechando aba: ${handle}
    Switch Window    handle=${handle}
    Close Window


Verificar Login
    Log    Verificando usuário logado
    Wait Until Element Is Visible    id=userActionsMenuHeaderButton    30s
    ${user_name}=    Get Text    id=userActionsMenuHeaderButton
    Log    Usuário logado: ${user_name}
    Should Contain    ${user_name}    ${USERNAME}
