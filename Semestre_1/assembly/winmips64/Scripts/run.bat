@echo off
setlocal EnableExtensions EnableDelayedExpansion
title Assembly - compilar e executar (x86 / x64)
cd /d "%~dp0"

REM ============================================================
REM  Escolhe um ficheiro .s / .asm, compila e executa a seguir.
REM   - nasm (x86 / x64) -> nasm + gcc, compila e corre logo
REM   - winmips64 (MIPS) -> monta e abre o simulador
REM ============================================================

call :check_tools || goto :fim_erro
call :escolher_ficheiro || goto :fim_erro

REM ---- parte o caminho em nome / extensao / directoria ----
set "NAME="
set "EXT="
set "DIR="
set "FULL="
for %%F in ("%SRC%") do (
    set "NAME=%%~nF"
    set "EXT=%%~xF"
    set "DIR=%%~dpF"
    set "FULL=%%~fF"
)

echo.
echo --------------------------------------------------
echo  Ficheiro : !NAME!!EXT!
echo  Caminho  : !FULL!
echo --------------------------------------------------
echo.

REM ---- deteta o tipo de codigo ----
set "TIPO="
findstr /i /c:".intel_syntax" /c:"syscall" "!FULL!" >nul 2>&1 && set "TIPO=nasm"
if not defined TIPO findstr /i /c:"halt" /c:"dadd" /c:"daddu" "!FULL!" >nul 2>&1 && set "TIPO=mips"
if not defined TIPO set "TIPO=nasm"
if /i "!TIPO!"=="mips" goto :mips

REM ================= x86 / x64 (NASM) =================
set "ARCH=win64"
echo  Arquitetura do executavel:
echo    1) x64  - nasm -f win64   (padrao)
echo    2) x86  - nasm -f win32
set "OPARQ="
set /p "OPARQ=  Escolhe [1]: "
set "OPARQ=!OPARQ: =!"
if "!OPARQ!"=="2" set "ARCH=win32"

set "EXE=!DIR!!NAME!.exe"
set "OBJ=%TEMP%\!NAME!.obj"

echo.
echo  [1/3] a assemblar com nasm -f !ARCH! ...
nasm -f !ARCH! -o "%OBJ%" "!FULL!"
if errorlevel 1 goto :erro_nasm

echo  [2/3] a ligar com !LDNAME! ...
if /i "!LDNAME!"=="gcc" goto :linka_gcc
ld -e main --subsystem console -o "%EXE%" "%OBJ%"
if errorlevel 1 goto :erro_link
goto :executa

:linka_gcc
gcc -o "%EXE%" "%OBJ%"
if errorlevel 1 goto :erro_link

:executa
echo  [3/3] a executar !NAME!.exe ...
echo --------------------------------------------------
echo.
"%EXE%"
set "RC=!errorlevel!"
del /q "%OBJ%" >nul 2>&1
echo.
echo --------------------------------------------------
echo  Codigo de saida: !RC!
goto :fim

:erro_nasm
echo.
echo  [ERRO] o nasm falhou - nao foi gerado nenhum executavel.
echo  Dica: no NASM 3.x a sintaxe Intel ja e a predeterminada, por isso
echo        a linha ".intel_syntax noprefix" da erro - apaga-a.
goto :limpa

:erro_link
echo.
echo  [ERRO] a ligacao falhou.
goto :limpa

REM ================= MIPS64 (winmips64) =================
:mips
if not exist "%~dp0..\asm.exe" goto :erro_mips
echo  Codigo MIPS64 detectado.
echo.
echo  [1/2] a montar com asm.exe ...
pushd "%~dp0.."
"%~dp0..\asm.exe" "!FULL!"
set "ASMRC=!errorlevel!"
popd
if not "!ASMRC!"=="0" goto :erro_asm

echo.
echo  [2/2] simulador ...
echo  O winmips64.exe tem de ser aberto SEM argumentos: passar-lhe o
echo  ficheiro, ou ter um programa lembrado no winmips64.las, faz com
echo  que crash com 0xC0000005 (ver Event Viewer - Windows Logs).
echo  A abrir em segundo plano. Se a janela nao aparecer, apaga o
echo  winmips64.las e abre o fonte por File - Open dentro do simulador.
echo.
start "" "%~dp0..\winmips64.exe"
goto :fim

:erro_asm
echo.
echo  [ERRO] o asm.exe reportou erros - corrige o fonte e tenta outra vez.
goto :limpa

:erro_mips
echo  [ERRO] asm.exe nao encontrado na pasta acima desta.
goto :limpa

REM ============================================================

:escolher_ficheiro
echo  Ficheiros em %~dp0
set /a N=0
for %%F in ("%~dp0*.asm" "%~dp0*.s") do (
    set /a N+=1
    if !N! leq 10 set "F!N!=%%~nxF"
    if !N! leq 10 echo     !N!^) %%~nxF
)
if !N!==0 echo     (nenhum ficheiro .asm ou .s nesta pasta)
echo.
echo    0) escolher outro ficheiro...
echo.
set "OP="
set /p "OP=  Numero: "
set "OP=!OP: =!"
if not defined OP goto :sem_escolha
if "!OP!"=="0" goto :escolher_outro

REM ---- volta a percorrer os mesmos ficheiros e guarda o escolhido ----
set "N=0"
set "SRC="
for %%F in ("%~dp0*.asm" "%~dp0*.s") do (
    set /a N+=1
    if !N!==!OP! set "SRC=%%~fF"
)
if not defined SRC goto :op_invalida
exit /b 0

:sem_escolha
echo  Nao escolheste nenhum ficheiro.
exit /b 1

:op_invalida
echo  Opcao invalida.
exit /b 1

:escolher_outro
set "SRC="
for /f "usebackq delims=" %%F in (`powershell -NoProfile -Command "Add-Type -AssemblyName System.Windows.Forms; $d = New-Object System.Windows.Forms.OpenFileDialog; $d.Filter = 'Assembly (*.s;*.asm)'; if ($d.ShowDialog() -eq 'OK') { Write-Output $d.FileName }"`) do set "SRC=%%F"
if not defined SRC goto :sem_escolha
exit /b 0

:check_tools
set "NASM="
set "LDNAME="
for /f "delims=" %%I in ('where nasm 2^>nul') do if not defined NASM set "NASM=%%I"
if not defined NASM goto :erro_nasm_tool
for /f "delims=" %%I in ('where gcc 2^>nul') do if not defined LDNAME set "LDNAME=gcc"
if not defined LDNAME for /f "delims=" %%I in ('where ld 2^>nul') do if not defined LDNAME set "LDNAME=ld"
if not defined LDNAME goto :erro_ld_tool
exit /b 0

:erro_nasm_tool
echo  [ERRO] nasm nao esta no PATH - instala o NASM em https://www.nasm.us/
exit /b 1

:erro_ld_tool
echo  [ERRO] nem gcc nem ld estao no PATH - instala o MinGW ou o WinLibs.
exit /b 1

:limpa
del /q "%TEMP%\!NAME!.obj" >nul 2>&1

:fim_erro
echo.
pause
endlocal
exit /b 1

:fim
echo.
pause
endlocal
