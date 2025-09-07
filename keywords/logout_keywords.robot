*** Settings ***
Resource    ../variables/variables.robot
Library     SeleniumLibrary

*** Keywords ***
Fazer Logout
    Log    Iniciando logout
    # Abre menu do usuário
    Wait Until Element Is Visible    id=userActionsMenuHeaderButton    15s
    Click Element    id=userActionsMenuHeaderButton

    # Clica na opção Sign Out
    Wait Until Element Is Visible    xpath=//div[@class='sapMSLITitleOnly' and normalize-space(.)='Sign Out']    10s
    Click Element    xpath=//div[@class='sapMSLITitleOnly' and normalize-space(.)='Sign Out']
    Sleep    2s

    # Confirma popup de saída
    Wait Until Element Is Visible    id=__mbox-btn-0-BDI-content    10s
    Click Element    id=__mbox-btn-0-BDI-content

    Log    Logout realizado com sucesso
    Close Browser
