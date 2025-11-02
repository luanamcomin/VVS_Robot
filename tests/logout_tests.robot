*** Settings ***
Library    SeleniumLibrary
Library    BuiltIn
Resource   ../resources/keywords.robot
Resource   ../variables/variables.robot

*** Test Cases ***
Logout Do Sistema
    Open Browser To Login Page
    Login With Valid Credentials
    Perform Logout
    Take Evidence Screenshot    logout_ok
    Close Browser Session
