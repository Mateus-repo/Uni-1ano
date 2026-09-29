@echo off
setlocal EnableExtensions EnableDelayedExpansion
title Pratica C/C++ - compilar e executar
cd /d "%~dp0"

REM ============================================================
REM  Escolhe um .cpp / .c em qualquer subpasta, compila com o
REM  g++ (ou gcc) e executa o .exe a seguir.
REM
REM    - procuras em todo o lado, subpastas incluidas
REM    - da para escrever o caminho a mao
REM    - da para pesquisar por nome (ou parte do nome)
REM ============================================================

set "ROOT=%~dp0"
call set "ROOTSEM=%%ROOT:~0,-1%%"
call set "RLEN=%%ROOTSEM:~0,-1%%"
set "LISTA=%TEMP%\pratica_cpp_lista.txt"
set "PSALVA=%TEMP%\pratica_cpp_ps.txt"
set "LIXO=%TEMP%\pratica_cpp_lixo.txt"
set "ORDEM=%TEMP%\pratica_cpp_ordem.txt"

call :limpa_temporarios
call :check_tools || goto :fim_erro

echo  Compilador: !GXX!
if defined GCC echo              e tambem: !GCC!

call :escolher_ficheiro || goto :fim_erro

REM ---- parte o caminho em nome / extensao / directoria ----
for %%F in ("%SRC%") do (
    set "NAME=%%~nF"
    set "EXT=%%~xF"
    set "DIR=%%~dpF"
)

echo.
echo --------------------------------------------------
echo  Fonte   : !NAME!!EXT!
echo  Caminho : %SRC%
echo --------------------------------------------------
echo.

REM ---- .c e para o gcc, o resto para o g++ ----
set "COMP=!GXX!"
if /i "!EXT!"==".c" if defined GCC set "COMP=!GCC!"

set "LANG=c++"
if /i "!EXT!"==".c" set "LANG=c"

echo  Standard do !LANG!:
echo    1) !LANG!17 / !LANG!11  (padrao)
echo    2) !LANG!11 / !LANG!99
echo    3) !LANG!20
echo    4) sem -std (usa o que o compilador tiver por omissao)
set "OPARQ="
set /p "OPARQ=  Escolhe [1]: "
set "OPARQ=!OPARQ: =!"
set "STD=-std=!LANG!17"
if "!OPARQ!"=="2" set "STD=-std=!LANG!11"
if "!OPARQ!"=="3" set "STD=-std=!LANG!20"
if "!OPARQ!"=="4" set "STD="

echo.
echo  Compilacao:
echo    1) rapida  -O2, e depois executa          (padrao)
echo    2) debug   -g -O0, e depois executa
echo    3) so compilar (gera o .exe e nao executa)
set "OPARQ="
set /p "OPARQ=  Escolhe [1]: "
set "OPARQ=!OPARQ: =!"
set "OPT=-O2 -Wall"
set "CORRER=1"
if "!OPARQ!"=="2" set "OPT=-g -O0 -Wall"
if "!OPARQ!"=="3" (
    set "OPT=-O2 -Wall"
    set "CORRER=0"
)

REM ---- o .exe fica na mesma pasta do fonte, com o mesmo nome ----
set "EXE=!DIR!!NAME!.exe"

echo.
echo --------------------------------------------------
echo  [1/2] a compilar com !COMP! !STD! !OPT!
echo --------------------------------------------------
"!COMP!" !STD! !OPT! -o "%EXE%" "%SRC%"
if errorlevel 1 goto :erro_comp
echo  [OK] gerado !EXE!

if "!CORRER!"=="0" goto :fim
if not exist "%EXE%" goto :fim

echo.
echo --------------------------------------------------
echo  [2/2] a executar !NAME!.exe ...
echo --------------------------------------------------
echo.
pushd "!DIR!"
"%EXE%"
set "RC=!errorlevel!"
popd
echo.
echo --------------------------------------------------
echo  Codigo de saida: !RC!
goto :fim

:erro_comp
echo.
echo  [ERRO] a compilacao falhou - nenhum executavel novo.
echo  Dica: o .exe anterior pode estar a correr. Fecha-o e tenta outra vez.
goto :limpa

REM ============================================================
REM                  escolher o ficheiro a compilar
REM ============================================================

:escolher_ficheiro
call :criar_lista || goto :sem_lista
call :contar "%LISTA%" N
if "!N!"=="0" goto :sem_lista
call :menu_ficheiro
if not defined OP goto :sem_escolha
REM ---- tira os espacos, e repara se sobrou so whitespace ----
set "OP=!OP: =!"
if not defined OP goto :sem_escolha
if "!OP!"=="0" goto :escolher_manual
if "!OP!"=="9" goto :escolher_pesquisa
echo !OP!| findstr /r /c:"^[0-9][0-9]*$" >nul || goto :op_invalida
call :pega "%LISTA%" "!OP!"
if not defined REL goto :op_invalida
set "SRC=%ROOT%!REL!"
exit /b 0

:sem_lista
echo  [ERRO] nao encontrei nenhum .cpp nem .c em %ROOT%
echo         (nem nas subpastas). Cria um ficheiro e tenta outra vez.
exit /b 1

:op_invalida
echo  Opcao invalida.
set "OP="
goto :menu_ficheiro

:sem_escolha
echo.
echo  Nao escolheste nenhum ficheiro.
exit /b 1

REM ---- escrever o caminho a mao ----
:escolher_manual
echo.
set "SRC="
set "TYPED="
set /p "TYPED=  Caminho (completo ou a partir desta pasta) ou nome do ficheiro: "
if not defined TYPED goto :menu_ficheiro
REM ---- tira as aspas, caso as tenham colado ----
set "TYPED=!TYPED:"=!"
if exist "!TYPED!\" goto :nao_e_ficheiro
if exist "!TYPED!" (
    call :abspath "!TYPED!"
    exit /b 0
)
if exist "%ROOT%!TYPED!\" goto :nao_e_ficheiro
if exist "%ROOT%!TYPED!" (
    set "SRC=%ROOT%!TYPED!"
    exit /b 0
)
REM ---- nao existe onde foi escrito: procura em todo o lado ----
call :procurar "!TYPED!" "%LIXO%"
call :contar "%LIXO%" NX
echo.
if "!NX!"=="0" (
    echo  Nao encontrei "!TYPED!" nesta pasta nem nas subpastas.
    set "OP="
    goto :menu_ficheiro
)
goto :escolher_resultado

:nao_e_ficheiro
echo  Isso e uma pasta, nao um ficheiro.
set "OP="
goto :menu_ficheiro

REM ---- pesquisar por nome, ou parte do nome ----
:escolher_pesquisa
echo.
set "TERM="
set /p "TERM=  Nome a procurar (pode ser parcial, ex: ex6): "
if not defined TERM goto :menu_ficheiro
call :procurar "*!TERM!*.*" "%LIXO%"
call :contar "%LIXO%" NX
echo.
if "!NX!"=="0" (
    echo  Nada encontrado para "!TERM!".
    set "OP="
    goto :menu_ficheiro
)
goto :escolher_resultado

REM ---- da lista dos resultados a escolher um ----
:escolher_resultado
if "!NX!"=="1" (
    call :pega "%LIXO%" 1
    set "SRC=%ROOT%!REL!"
    exit /b 0
)
echo  !NX! resultados:
echo.
set /a K=0
set "MAIS=0"
for /f "usebackq delims=" %%F in ("%LIXO%") do (
    set /a K+=1
    if !K! leq 30 echo     !K!^) %%F
    if !K! gtr 30 set "MAIS=1"
)
if "!MAIS!"=="1" echo     ... e !NX! no total
echo.
set "OP="
set /p "OP=  Numero: "
set "OP=!OP: =!"
if not defined OP goto :menu_ficheiro
echo !OP!| findstr /r /c:"^[0-9][0-9]*$" >nul || goto :menu_ficheiro
call :pega "%LIXO%" "!OP!"
if not defined REL goto :menu_ficheiro
set "SRC=%ROOT%!REL!"
exit /b 0

REM ---- menu com os ficheiros todos ----
:menu_ficheiro
echo.
echo  Ficheiros em %ROOT% (subpastas incluidas):
echo.
set "OP="
set /a K=0
set "MAIS=0"
for /f "usebackq delims=" %%F in ("%LISTA%") do (
    set /a K+=1
    if !K! leq 30 echo     !K!^) %%F
    if !K! gtr 30 set "MAIS=1"
)
if "!MAIS!"=="1" echo     ... e !N! no total - para escolher, usa a opcao 9
echo.
echo    0) escrever o caminho do ficheiro a mao...
echo    9) procurar por nome (ou parte do nome)...
echo.
set /p "OP=  Numero: "
exit /b 0

REM ============================================================
REM                        rotinas de apoio
REM ============================================================

REM ---- lista todos os .cpp / .c da pasta e das subpastas ----
:criar_lista
if exist "%LISTA%" del /q "%LISTA%"
powershell -NoProfile -Command "$r='%ROOT%'; Get-ChildItem -LiteralPath $r -Recurse -File | Where-Object { $_.Extension -in '.cpp','.c','.cc','.cxx' } | ForEach-Object { $_.FullName.Substring($r.Length) } | Sort-Object" > "%PSALVA%" 2>nul
if exist "%PSALVA%" for %%A in ("%PSALVA%") do if %%~zA gtr 0 (
    move /y "%PSALVA%" "%LISTA%" >nul
    exit /b 0
)
del /q "%PSALVA%" >nul 2>&1
REM ---- sem powershell: o for /r, que e o que funciona sem /
:procurar "*.cpp *.c *.cc *.cxx" "%LISTA%"
exit /b 1

REM ---- procura em todo o lado e guarda caminhos relativos em %2! ----
REM      %1 = padrao, com * e ? se o ficheiro nao for exacto
:procurar
if exist "%~2" del /q "%~2"
for /r "%ROOT%" %%F in (%~1) do (
    set "EXT=%%~xF"
    set "SAIR="
    if /i "!EXT!"==".cpp" set "SAIR=1"
    if /i "!EXT!"==".c" set "SAIR=1"
    if /i "!EXT!"==".cc" set "SAIR=1"
    if /i "!EXT!"==".cxx" set "SAIR=1"
    if defined SAIR (
        set "LN=%%~fF"
        if /i "!LN:~0,%RLEN%!"=="%ROOTSEM%" set "LN=!LN:~%RLEN%!"
        echo(!LN!>>"%~2"
    )
)
call :ordenar "%~2"
exit /b 0

REM ---- ordena a lista (a do for /r sai por ordem de pasta) ----
:ordenar
if not exist "%~1" exit /b 1
for %%A in ("%~1") do if %%~zA gtr 0 (
    sort "%~1" > "%ORDEM%" 2>nul
    if exist "%ORDEM%" for %%B in ("%ORDEM%") do if %%~zB gtr 0 (
        move /y "%ORDEM%" "%~1" >nul
        exit /b 0
    )
    del /q "%ORDEM%" >nul 2>&1
)
exit /b 0

REM ---- conta as linhas de uma lista, para o %2! ----
:contar
set /a %~2=0
if exist "%~1" for /f "usebackq delims=" %%F in ("%~1") do set /a %~2+=1
exit /b 0

REM ---- guarda em REL a linha %2! de uma lista ----
:pega
set "REL="
set /a K=0
for /f "usebackq delims=" %%F in ("%~1") do (
    set /a K+=1
    if !K! equ %~2 set "REL=%%F"
)
exit /b 0

:abspath
for %%F in ("%~1") do set "SRC=%%~fF"
exit /b 0

:check_tools
set "GXX="
set "GCC="
for /f "delims=" %%I in ('where g++ 2^>nul') do if not defined GXX set "GXX=%%I"
for /f "delims=" %%I in ('where gcc 2^>nul') do if not defined GCC set "GCC=%%I"
if not defined GXX if not defined GCC goto :erro_tool
exit /b 0

:erro_tool
echo  [ERRO] nem g++ nem gcc estao no PATH.
echo         Instala o MinGW (por exemplo o WinLibs) e abre uma janela
echo         de comando nova, para o PATH actualizar.
exit /b 1

:limpa_temporarios
del /q "%LISTA%" "%PSALVA%" "%LIXO%" "%ORDEM%" >nul 2>&1
exit /b 0

:limpa
call :limpa_temporarios

:fim_erro
echo.
pause
endlocal
exit /b 1

:fim
call :limpa_temporarios
echo.
pause
endlocal
