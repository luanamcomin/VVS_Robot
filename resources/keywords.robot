*** Settings ***
Library    SeleniumLibrary
Library    BuiltIn
Resource   ../variables/variables.robot

*** Keywords ***
Open Browser To Login Page
    Open Browser    ${URL}    ${BROWSER}
    Set Selenium Speed    ${SELENIUM_SPEED}
    Maximize Browser Window
    Wait Until Page Contains Element    css:input[name="username"]    10s

Login With Valid Credentials
    Input Text    css:input[name="username"]    ${USERNAME}
    Input Text    css:input[name="password"]    ${PASSWORD}
    Click Button   css:button[type="submit"]
    Wait Until Page Contains Element    xpath=//h6[normalize-space()="Dashboard"]    10s

Verify On Dashboard
    Wait Until Page Contains Element    xpath=//h6[normalize-space()="Dashboard"]    10s

Go To PIM Module
    Click Element    xpath=//span[normalize-space()="PIM"]
    Wait Until Page Contains Element    xpath=//h6[normalize-space()="PIM"]    10s

Go To Add Employee
    Go To PIM Module
    Click Element    xpath=//a[normalize-space()="Add Employee"] | //button[.//text()[normalize-space()="Add"]]
    Wait Until Page Contains Element    xpath=//h6[normalize-space()="Add Employee"]    10s

Add Employee
    [Arguments]    ${first}    ${last}
    Input Text    css:input[name="firstName"]    ${first}
    Input Text    css:input[name="lastName"]     ${last}
    Click Button   css:button[type="submit"]
    Wait Until Page Contains Element    xpath=//h6[contains(normalize-space(),"Personal Details")]    10s

Search Employee By Name
    [Arguments]    ${name}
    Go To PIM Module
    Wait Until Page Contains Element    xpath=//h6[normalize-space()="PIM"]    10s
    Click Element    xpath=(//label[normalize-space()="Employee Name"]/following::input)[1]
    Input Text       xpath=(//label[normalize-space()="Employee Name"]/following::input)[1]    ${name}
    Sleep    0.5s
    Click Button     xpath=//button[.//text()[normalize-space()="Search"]]
    Wait Until Page Contains Element    css:div.oxd-table-body    10s

Assert Results Table Not Empty
    ${count}=    Get Element Count    xpath=//div[contains(@class,'oxd-table-body')]/div[contains(@class,'oxd-table-card')]
    Should Be True    ${count} > 0

Perform Logout
    Click Element    css=span.oxd-userdropdown-tab
    Click Element    xpath=//a[normalize-space()="Logout"]
    Wait Until Page Contains Element    css:input[name="username"]    10s

Take Evidence Screenshot
    [Arguments]    ${name}
    Capture Page Screenshot    ${name}.png

Close Browser Session
    Close All Browsers
