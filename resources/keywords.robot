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
    [Documentation]    Adiciona um novo funcionário com nome, sobrenome e um ID aleatório
    ...    
    [Arguments]    ${first}=${EMPLOYEE_FIRST_NAME}    ${last}=${EMPLOYEE_LAST_NAME}    ${id}=${RANDOM_EMPLOYEE_ID}
    
    # Gera um ID aleatório de 5 dígitos se não existir
    Run Keyword If    '${RANDOM_EMPLOYEE_ID}' == '${EMPTY}'
    ...    Generate Random Employee ID
    
    # Força a limpeza do campo de ID (tentativa adicional)
    Press Keys    ${INPUT_EMPLOYEE_ID}    BACKSPACE    BACKSPACE    BACKSPACE    BACKSPACE    BACKSPACE
    Sleep    0.5s  # Pequena pausa para garantir que a limpeza seja processada
    
    # Preenche os dados básicos do funcionário
    Input Text    ${INPUT_FIRST_NAME}    ${first}
    Input Text    ${INPUT_LAST_NAME}     ${last}
    Input Text    ${INPUT_EMPLOYEE_ID}    ${RANDOM_EMPLOYEE_ID}
    
    # Submete o formulário e verifica se foi bem sucedido
    Click Button    ${BUTTON_SUBMIT}
    Wait Until Page Contains Element    xpath=//h6[contains(normalize-space(),"Personal Details")]    10s    
    ...    error=Não foi possível adicionar o funcionário. Página de detalhes não carregou.

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

Generate Random Employee ID
    [Documentation]    Gera um ID aleatório de 5 dígitos e armazena em ${RANDOM_EMPLOYEE_ID}
    ${RANDOM_EMPLOYEE_ID}=    Evaluate    str(__import__('random').randint(10000, 99999))
    Set Global Variable    ${RANDOM_EMPLOYEE_ID}

Close Browser Session
    Close All Browsers
