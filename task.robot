*** Reset user dashboard***


*** Settings ***
Documentation       Template robot main suite.
Library    RPA.Browser.Selenium    auto_close=${FALSE}
Library    RPA.Excel.Files
Library    Telnet
Library    RPA.Desktop
*** KeyWord ***

Ejecutar y leer archivo
    Open Workbook    Accedieron.xlsx
    ${usuarios}=    Read Worksheet As Table    header=True
    Close Workbook
    Open Available Browser
    FOR    ${usuario}    IN    @{usuarios}
        Resetear plantilla para un usuario    ${usuario}
    END

Login
    Input Text When Element Is Visible    id:username    usuario
    Input Text When Element Is Visible    id:password    contraseña
    Click Button When Visible    id:loginbtn

Cerrar deslogearse
    click Link    Salir

Click ingresar como
    Click Link    Ingresar como

Click en continuar
    Click Button    Continuar
Click resetear plantilla
    Click Button    Personalizar esta página
    Click Button    Reiniciar página a predeterminada

Resetear plantilla para un usuario
    [Arguments]    ${usuario}
    Go To   ${usuario}[Link]
    Login
    Click ingresar como
    Click en continuar
    Click resetear plantilla
    Cerrar deslogearse

*** Tasks ***
Ejecutar Programa
    Ejecutar y leer archivo




