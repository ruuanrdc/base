:inicio
@echo off
cls
color 4
echo ---------------------------------------------------
echo --------------- MENU DO SERVIDOR ------------------
echo.
echo      Para ligar o SERVIDOR Digite 1
echo.
echo      Para limpar o CACHE Digite 2
echo.
echo      Para Reiniciar a Cidade Digite 3
echo.
echo      Para Desligar a Cidade Digite 4
echo.
echo      Para sair do MENU Digite 0 Ou tecle ENTER
echo.
echo ---------------------------------------------------





set /p Comando= Digite uma Opcao : 

if "%Comando%" equ "0" (goto:exit)
if "%Comando%" equ "1" (goto:op1)
if "%Comando%" equ "2" (goto:op2)
if "%Comando%" equ "3" (goto:op3)
if "%Comando%" equ "4" (goto:op4)

cls

:exit
exit

:op1
echo Ligando o SERVIDOR aguarde...
start ..\artifacts\FXServer.exe +set onesync on +set onesync_enableInfinity 1 +set sv_enforceGameBuild 2372 +set onesync_enableBeyond 1 +set onesync_forceMigration 1 +set onesync_distanceCullVehicles 1 +exec server.cfg
goto:inicio

:op2
echo Limpando o CACHE da base aguarde...
rd /s /q "cache"
goto:inicio

:op3
echo Reiniciando a Cidade...
taskkill /f /im FXServer.exe
start ..\artifacts\FXServer.exe +set onesync on +set sv_enforceGameBuild 2372 +set onesync_enableInfinity 1 +set onesync_enableBeyond 1 +set onesync_forceMigration 1 +set onesync_distanceCullVehicles 1 +exec server.cfg
goto:inicio

:op4
echo Desligando a Cidade...
taskkill /f /im FXServer.exe
goto:inicio

:exit
exit