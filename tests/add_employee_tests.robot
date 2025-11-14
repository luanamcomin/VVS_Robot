*** Settings ***
Library    SeleniumLibrary
Library    BuiltIn
Resource   ../resources/keywords.robot
Resource   ../variables/variables.robot

*** Test Cases ***
Adicionar Novo Funcionario
    Open Browser To Login Page
    Login With Valid Credentials
    Go To Add Employee
    ${rand}=    Evaluate    __import__('random').randint(1000, 9999)
    Add Employee    ${EMPLOYEE_FIRST_NAME} ${rand}    ${EMPLOYEE_LAST_NAME}
    Take Evidence Screenshot    add_employee_ok
    Close Browser Session
