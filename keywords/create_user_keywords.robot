*** Settings ***
Resource    ../variables/variables.robot
Resource    go_to_home_keywords.robot
Library     SeleniumLibrary
Library     DateTime


*** Keywords ***
Voltar Para Tela Anterior
    # Tenta localizar botão ou ícone de Back
    ${voltar_locators}=    Create List    xpath=//button[@title='Back']    xpath=//span[contains(@class,"sapUshellShellHeadItmCntnt")]    xpath=//span[.='']
    ${clicked}=    Set Variable    ${False}
    FOR    ${loc}    IN    @{voltar_locators}
        ${present}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${loc}    3s
        Run Keyword If    ${present}    Click Element    ${loc}
        Run Keyword If    ${present}    Set Variable    ${clicked}    ${True}
        Run Keyword If    ${present}    Exit For Loop
    END
    Run Keyword Unless    ${clicked}    Go Back
    Log    Retornou para tela anterior

*** Keywords ***
Handle Partner Selection Popup
    ${popup_present}=    Run Keyword And Return Status    Wait Until Element Is Visible    xpath=//div[@role='dialog' and .//span[contains(text(), 'Partner Selection')]]    5s
    Run Keyword If    ${popup_present}    Click Element    xpath=(//div[@role='dialog' and .//span[contains(text(), 'Partner Selection')]]//div[@role='button' and @title='Continue (Enter)'])[1]
    RETURN
Criar Sales Order
    Log    Open Manage Sales Orders screen.
    Go To    ${MANAGE_ORDER_URL}
    Wait Until Page Contains Element    xpath=//span[text()='Manage Sales Orders']    30s
    Log    The Manage Sales Orders screen displays.

    Click Element    xpath=//button[.//bdi[text()='Create']]
    Click Element    xpath=//div[normalize-space()='Create Sales Order - VA01']
    Log    Choose 'Create Sales Orders - VA01' button

    Wait Until Page Contains Element    xpath=//span[contains(text(), 'Create Sales Document')]    30s
    Sleep    10s
    # Entra no iframe que contém os campos da VA01
    Select Frame    id=application-SalesOrder-create-iframe
    Wait Until Element Is Visible    xpath=//input[@name='InputField' and @title='Sales Document Type']    30s
    Log    The Create Sales Order Screen displays.

    Input Text    xpath=//input[@name='InputField' and @title='Sales Document Type']    ${ORDER_TYPE}
    Log    Order Type entered: ${ORDER_TYPE}

    Input Text    xpath=//input[@title='Sales Organization' and @class='lsField__input']    ${SALES_ORGANIZATION}
    Log    Sales Organization entered: ${SALES_ORGANIZATION}

    Input Text    xpath=//input[@title='Distribution Channel' and @class='lsField__input']    ${DISTRIBUTION_CHANNEL}
    Log    Distribution Channel entered: ${DISTRIBUTION_CHANNEL}

    Input Text    xpath=//input[@title='Division' and @class='lsField__input']    ${DIVISION}
    Log    Division entered: ${DIVISION}

    Log    Order details are entered.

    Click Element    xpath=//div[@role='button' and @title='Continue (Enter)']

    Wait Until Element Is Visible    xpath=//input[@title='Sold-to Party' and @class='lsField__input']    30s

    Input Text    xpath=//input[@title='Sold-to Party' and @class='lsField__input']    ${SOLD_TO_PARTY}
    Log    Sold-to Party entered: ${SOLD_TO_PARTY}

    Input Text    xpath=//input[@title='Ship-to Party' and @class='lsField__input']    ${SHIP_TO_PARTY}
    Log    Ship-to Party entered: ${SHIP_TO_PARTY}

    Input Text    xpath=//input[@title='Customer Reference' and @class='lsField__input']    ${CUSTOMER_REFERENCE}
    Log    Customer Reference entered: ${CUSTOMER_REFERENCE}
    Press Keys    xpath=//input[@title='Customer Reference' and @class='lsField__input']    ENTER

    # Trata popup Partner Selection se aparecer
    Run Keyword And Ignore Error    Handle Partner Selection Popup

    Log    The customer information is entered.

    # Preenche primeira linha da tabela de itens
    Wait Until Element Is Visible    xpath=//input[contains(@lsdata,'RV45A-MABNR')]    30s

    # Material (input)
    ${LOC_MATERIAL}=    Set Variable    xpath=//input[contains(@lsdata,'RV45A-MABNR')]
    Input Text    ${LOC_MATERIAL}    ${MATERIAL}
    Log    Material entered: ${MATERIAL}
    # Confirma Material e move para próxima coluna
    Press Keys    ${LOC_MATERIAL}    ENTER

    # Order Quantity (input)
    ${LOC_QTY}=    Set Variable    xpath=//input[contains(@id,'[1,3]_c') and @name='InputField']
    Wait Until Element Is Visible    ${LOC_QTY}    10s
    Input Text    ${LOC_QTY}    ${ORDER_QUANTITY}
    Log    Order Quantity entered: ${ORDER_QUANTITY}
    Press Keys    ${LOC_QTY}    ENTER

    # Plant
    Click Element    xpath=//span[contains(@lsdata,'VBAP-WERKS') and @role='textbox']
    Press Keys       xpath=//span[contains(@lsdata,'VBAP-WERKS') and @role='textbox']    ${PLANT}
    Log    Plant entered: ${PLANT}

    Log    The item details are entered.


    Double Click Element    ${LOC_MATERIAL}
    Sleep    2s

    # Aguarda a nova tela e clica na aba Shipping
    Wait Until Element Is Visible    xpath=(//div[@role='tab' and contains(text(),'Shipping')])[1]    20s
    Scroll Element Into View    xpath=(//div[@role='tab' and contains(text(),'Shipping')])[1]
    Click Element   xpath=(//div[@role='tab' and contains(text(),'Shipping')])[1]

    # Verifica valor do campo Route na aba Shipping
    Wait Until Element Is Visible    xpath=//input[contains(@lsdata,'VBAP-ROUTE')]    15s
    ${ROUTE_ATUAL}=    Get Element Attribute    xpath=//input[contains(@lsdata,'VBAP-ROUTE')]    value
    Log    Route na aba Shipping: ${ROUTE_ATUAL}
    Should Be Equal    ${ROUTE_ATUAL}    ${ROUTE}

    # Acessa aba Conditions
    Wait Until Element Is Visible    xpath=//div[@role='tab' and normalize-space()='Conditions']    15s
    Scroll Element Into View    xpath=//div[@role='tab' and normalize-space()='Conditions']
    Click Element    xpath=//div[@role='tab' and normalize-space()='Conditions']

    # Verifica se o tipo de condição esperado está presente na tabela
    Wait Until Element Is Visible    xpath=//span[normalize-space(text())='${CONDITION_TYPE}']    15s
        Log    Condition type ${CONDITION_TYPE} found in the Conditions tab.

    # Acessa aba Schedule lines
    Wait Until Element Is Visible    xpath=//div[@role='tab' and normalize-space()='Schedule lines']    15s
    Scroll Element Into View    xpath=//div[@role='tab' and normalize-space()='Schedule lines']
    Click Element    xpath=//div[@role='tab' and normalize-space()='Schedule lines']

   # Verifica Delivery Date igual a data de hoje
    ${TODAY}=    Get Current Date    result_format=%d.%m.%Y
    Wait Until Element Is Visible    xpath=//input[contains(@lsdata,'RV45A-ETDAT')]    15s
    ${DELIV_DATE_RAW}=    Get Element Attribute    xpath=//input[contains(@lsdata,'RV45A-ETDAT')]    value
    Log    Delivery Date in the Schedule lines tab: ${DELIV_DATE_RAW}

    # Extrai apenas os 10 primeiros caracteres (data no formato dd.mm.yyyy)
    ${DELIV_DATE}=    Evaluate    '${DELIV_DATE_RAW}'[0:10]
    Log    Formatted Delivery Date: ${DELIV_DATE}

    Should Be Equal As Strings    ${DELIV_DATE}    ${TODAY}
    Log    Verified data

        Unselect Frame

    # Volta para tela anterior (Manage Sales Orders)
    Voltar Para Tela Anterior
    Sleep    3s

    # Reentra no iframe da VA01 para salvar
    Select Frame    id=application-SalesOrder-create-iframe

    # Salva a ordem
    Wait Until Element Is Visible    xpath=//div[@role='button' and contains(@title,'Save')]    20s
    Click Element    xpath=//div[@role='button' and contains(@title,'Save')]
    Sleep    3s

    Wait Until Element Is Visible    xpath=//span[contains(@id,'sbar_msg-txt')]    20s
    ${STATUS_MSG}=    Get Text    xpath=//span[contains(@id,'sbar_msg-txt')]
    Log    📋 Mensagem SAP: ${STATUS_MSG}

# Extrai número do pedido com regex
    ${digits}=    Evaluate    re.findall(r'\\d+', """${STATUS_MSG}""")    re
    Run Keyword If    ${digits} == []    Fail    Número da ordem não encontrado na mensagem: ${STATUS_MSG}
    ${ORDER_NUMBER}=    Set Variable    ${digits}[0]
    Log    ✅ Pedido criado: ${ORDER_NUMBER}

    Unselect Frame
    Voltar Para Home