*** Reset user dashboard***


*** Settings ***
Documentation       Template robot main suite.
Library    RPA.Browser.Selenium    auto_close=${FALSE}
Library    RPA.Excel.Files

*** Variables ***
${resultado}    Set Variables    FALSE

*** KeyWord ***

Ejecutar y leer archivo
    Open Workbook    usuarios.xlsx
    ${usuarios}=    Read Worksheet As Table    header=True
    Close Workbook
    Open Available Browser
    FOR    ${usuario}    IN    @{usuarios}
        Resetear plantilla para un usuario    ${usuario}
    END

Login
    Input Text When Element Is Visible    id:username    username 
    Input Text When Element Is Visible    id:password    password
    Click Button When Visible    id:loginbtn

Cerrar deslogearse
    click Link    Salir

Click ingresar como
    Click Link    Ingresar como

Click en continuar
    Click Button    Continuar
Click resetear plantilla
    
    TRY
        Set Selenium Implicit Wait    2s
        Click Button    Terminar tour
        Click Button    Personalizar esta página
        Click Button    Reiniciar página a predeterminada
    EXCEPT
        Click Button    Personalizar esta página
        Click Button    Reiniciar página a predeterminada
    END
        

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
