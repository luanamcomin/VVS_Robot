*** Settings ***
Resource    ../variables/variables.robot
Library     SeleniumLibrary

*** Keywords ***
Fazer Logout
    [Documentation]    Realiza o logout do usuário
    Wait Until Page Contains Element    ${LOGOUT_LINK}
    Click Link    ${LOGOUT_LINK}
    Wait Until Page Contains Element    ${LOGIN_LINK}