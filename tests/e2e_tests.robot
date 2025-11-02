*** Settings ***
Library    SeleniumLibrary
Library    BuiltIn
Resource   ../resources/keywords.robot
Resource   ../variables/variables.robot

*** Test Cases ***
Ciclo Ponta A Ponta - OrangeHRM
    [Documentation]    Fluxo completo: Login -> Dashboard -> Adicionar Funcionário -> Buscar Funcionário -> Logout
    Set Selenium Speed    0.6 seconds
    Open Browser To Login Page
    Login With Valid Credentials
    Verify On Dashboard
    Take Evidence Screenshot    e2e_dashboard

    Go To Add Employee
    ${rand}=    Evaluate    __import__('random').randint(10000, 99999)
    ${first}=   Set Variable    Emp${rand}
    ${last}=    Set Variable    Silva
    ${fullname}=    Set Variable    ${first} ${last}
    Add Employee    ${first}    ${last}
    Take Evidence Screenshot    e2e_add_employee

    Go To PIM Module
    Search Employee By Name    ${fullname}
    Assert Results Table Not Empty
    Take Evidence Screenshot    e2e_search_employee

    Perform Logout
    Take Evidence Screenshot    e2e_logout
    Close Browser Session