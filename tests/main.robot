*** Settings ***
Documentation     Fluxo completo SAP Fiori
Resource          ../resources/common_resources.robot
Suite Setup       Abrir Navegador e Acessar SAP

*** Test Cases ***
Fluxo Completo de Pedido de Venda
    Fazer Login
    Criar Sales Order
    #Gerenciar Sales Order
    Fazer Logout
