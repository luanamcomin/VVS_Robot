*** Settings ***
Library    SeleniumLibrary
Library    BuiltIn
Resource   ../resources/keywords.robot
Resource   ../variables/variables.robot

*** Test Cases ***
Login Com Credenciais Válidas
    Open Browser To Login Page
    Login With Valid Credentials
    Verify On Dashboard
    Take Evidence Screenshot    login_sucesso
    Close Browser Session
