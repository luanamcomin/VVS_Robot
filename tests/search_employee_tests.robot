*** Settings ***
Library    SeleniumLibrary
Library    BuiltIn
Resource   ../resources/keywords.robot
Resource   ../variables/variables.robot

*** Test Cases ***
Buscar Funcionario Por Nome
    Open Browser To Login Page
    Login With Valid Credentials
    Search Employee By Name    Linda
    Assert Results Table Not Empty
    Take Evidence Screenshot    search_employee_ok
    Close Browser Session
