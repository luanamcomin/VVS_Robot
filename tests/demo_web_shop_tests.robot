*** Settings ***
Documentation     Testes de registro e login de usuário no Demo Web Shop
Resource          ../resources/common_resources.robot
Test Setup        Abrir Navegador e Acessar o site
Test Teardown     Close Browser

*** Variables ***
${GENERATED_EMAIL}    ${EMPTY}

*** Test Cases ***
Registrar Novo Usuário
    [Documentation]    Testa o fluxo completo de registro de um novo usuário
    Clicar em Register
    Preencher Formulário de Registro
    Verificar Registro Bem Sucedido
    Clicar em Continuar
    ${email}=    Get Variable Value    ${GENERATED_EMAIL}
    Set Global Variable    ${GENERATED_EMAIL}    ${email}
    Log    Email salvo para login: ${GENERATED_EMAIL}    level=INFO
    logout_keywords.Fazer Logout

Fazer Login com Usuário Registrado
    [Documentation]    Testa o login com um usuário previamente registrado
    Log    Tentando fazer login com email: ${GENERATED_EMAIL}    level=INFO
    Fazer Login
    Verificar Login Bem Sucedido
    Fazer Logout

*** Keywords ***
# Todas as palavras-chave necessárias já estão importadas via common_resources.robot