@echo off
setlocal EnableExtensions EnableDelayedExpansion
title Assembly - compilar e executar (x86 / x64)
cd /d "%~dp0"

REM ============================================================
REM  Escolhe um ficheiro .s / .asm, compila e executa a seguir.
REM  - nasm (x86 / x64) -> nasm + gcc, compila e corre logo
REM  - winmips64 (MIPS) -> monta e abre o simulador
REM ============================================================

call :check_tools || goto :fim_erro
call :escolher_ficheiro || goto :fim_erro

echo.
echo --------------------------------------------------
echo  Ficheiro : %~nxSRC%
echo  Caminho  : %~fSRC%
echo --------------------------------------------------
echo.

REM ---- deteta o tipo de codigo ----
set "TIPO="
findstr /i /c:".intel_syntax" /c:"syscall" "%~fSRC%" >nul 2>&1 && set "TIPO=nasm"
if not defined TIPO findstr /i /c:"halt" /c:"dadd" /c:"daddu" "%~fSRC%" >nul 2>&1 && set "TIPO=mips"
if not defined TIPO set "TIPO=nasm"
if /i "%TIPO%"=="mips" goto :mips

REM ================= x86 / x64 (NASM) =================
echo  Arquitetura do executavel:
echo    1) x64  - nasm -f win64   (padrao)
echo    2) x86  - nasm -f win32
choice /c 12 /n /m "  Escolhe [1]: " >nul
set "ARCH=win64"
if errorlevel 2 set "ARCH=win32"

set "NAME=%~nSRC%"
set "EXE=%~dp0%NAME%.exe"
set "OBJ=%TEMP%\%NAME%.obj"

echo.
echo  [1/3] a assemblar com nasm -f %ARCH% ...
nasm -f %ARCH% -o "%OBJ%" "%~fSRC%"
if errorlevel 1 goto :erro_nasm

echo  [2/3] a ligar com %LDNAME% ...
if /i "%LDNAME%"=="gcc" goto :linka_gcc
ld -e main --subsystem console -o "%EXE%" "%OBJ%"
if errorlevel 1 goto :erro_link
goto :executa
:linka_gcc
gcc -o "%EXE%" "%OBJ%"
if errorlevel 1 goto :erro_link

:executa
echo  [3/3] a executar %NAME%.exe ...
echo --------------------------------------------------
echo.
"%EXE%"
set "RC=%errorlevel%"
del /q "%OBJ%" >nul 2>&1
echo.
echo --------------------------------------------------
echo  Codigo de saida: %RC%
goto :fim

:erro_nasm
echo.
echo  [ERRO] o nasm falhou - nao foi gerado nenhum executavel.
goto :limpa
:erro_link
echo.
echo  [ERRO] a ligacao falhou.
goto :limpa

REM ================= MIPS64 (winmips64) =================
:mips
if not exist "%~dp0..\winmips64.exe" goto :erro_mips
echo  Codigo MIPS64 detectado. A montar e a abrir o winmips64 ...
echo  (o simulador abre noutra janela; fecha-o para voltares aqui)
echo.
pushd "%~dp0.."
"%~dp0..\winmips64.exe" "%~dp0%~nxSRC%"
popd
goto :fim

:erro_mips
echo  [ERRO] winmips64.exe nao encontrado na pasta acima desta.
goto :limpa

REM ============================================================

:escolher_ficheiro
set /a N=0
for %%F in ("%~dp0*.asm") do call :add "%%fF"
for %%F in ("%~dp0*.s") do call :add "%%fF"

echo  Ficheiros em %~dp0
if %N%==0 goto :sem_ficheiros
for /l %%i in (1,1,%N%) do echo     %%i^) !F%%i!
:sem_ficheiros
echo     (nenhum ficheiro .asm ou .s nesta pasta)
echo.
echo    0) escolher outro ficheiro...
echo.
set "OP="
set /p "OP=  Numero: "
if not defined OP goto :sem_escolha
if "%OP%"=="0" goto :escolher_outro
set "PICK=!F%OP%!"
if not defined PICK goto :op_invalida
set "SRC=!PICK!"
exit /b 0

:sem_escolha
echo  Nao escolheste nenhum ficheiro.
exit /b 1
:op_invalida
echo  Opcao invalida.
exit /b 1

:escolher_outro
set "PICK="
for /f "usebackq delims=" %%F in (`powershell -NoProfile -Command "Add-Type -AssemblyName System.Windows.Forms; $d = New-Object System.Windows.Forms.OpenFileDialog; $d.Filter = 'Assembly (*.s;*.asm)'; if ($d.ShowDialog() -eq 'OK') { Write-Output $d.FileName }"`) do set "PICK=%%F"
if not defined PICK goto :sem_escolha
set "SRC=!PICK!"
exit /b 0

:add
set /a N+=1
if %N% leq 10 set "F%N%=%~nx1"
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
del /q "%TEMP%\%~nSRC%.obj" >nul 2>&1
:fim_erro
echo.
pause
endlocal
exit /b 1

:fim
echo.
pause
endlocal
