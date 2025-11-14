*** Variables ***
# Configurações do navegador e autenticação
${URL}              https://opensource-demo.orangehrmlive.com/web/index.php/auth/login
${BROWSER}          chrome
${SELENIUM_SPEED}   0.6 seconds

# Credenciais de login
${USERNAME}         Admin
${PASSWORD}         admin123

# Dados do funcionário
${EMPLOYEE_FIRST_NAME}    Danilo
${EMPLOYEE_LAST_NAME}     Silva
${RANDOM_EMPLOYEE_ID}     ${EMPTY}

# Localizadores - PIM/Add Employee
${INPUT_FIRST_NAME}       css:input[name="firstName"]
${INPUT_LAST_NAME}        css:input[name="lastName"]
${INPUT_EMPLOYEE_ID}      xpath=//label[contains(text(),'Employee Id')]/ancestor::div[contains(@class,'oxd-grid-item')]//input
${BUTTON_SUBMIT}          css:button[type="submit"]
