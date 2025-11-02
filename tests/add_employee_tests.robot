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
    ${rand}=    Evaluate    __import__('random').randint(10000, 99999)
    ${first}=   Set Variable    Emp${rand}
    ${last}=    Set Variable    Silva
    Add Employee    ${first}    ${last}
    Take Evidence Screenshot    add_employee_ok
    Close Browser Session
