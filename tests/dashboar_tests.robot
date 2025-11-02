*** Settings ***
Library    SeleniumLibrary
Library    BuiltIn
Resource   ../resources/keywords.robot
Resource   ../variables/variables.robot

*** Test Cases ***
Verificar Acesso Ao Dashboard
    Open Browser To Login Page
    Login With Valid Credentials
    Verify On Dashboard
    Take Evidence Screenshot    dashboard_ok
    Close Browser Session
