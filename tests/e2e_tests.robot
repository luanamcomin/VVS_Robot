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
    ${rand}=    Evaluate    __import__('random').randint(1000, 9999)
    ${fullname}=    Set Variable    ${EMPLOYEE_FIRST_NAME} ${rand} ${EMPLOYEE_LAST_NAME} 
    Add Employee    ${EMPLOYEE_FIRST_NAME} ${rand}    ${EMPLOYEE_LAST_NAME}
    Take Evidence Screenshot    e2e_add_employee

    Go To PIM Module
    Search Employee By Name    ${fullname}
    Assert Results Table Not Empty
    Take Evidence Screenshot    e2e_search_employee

    Perform Logout
    Take Evidence Screenshot    e2e_logout
    Close Browser Session