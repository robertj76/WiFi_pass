@echo off
chcp 65001
set nazwaprogramu=Program do odczytu nazw sieci i haseł WiFi.
color 1e

:menu
cls
echo  (c) 2019 Jex Corporation. Wszelkie prawa zastrzeżone.
echo.
echo  %nazwaprogramu%
echo.
echo  Wybierz:
echo  ========
echo    1 - Wyświetlenie nazw sieci WiFi i haseł.
echo    2 - Eksport do pliku XML sieci WiFi i haseł.
echo    Q - Wyjście.
echo.
set /p odp=">> "
if /I %odp% equ 1 goto 1
if /I %odp% equ 2 goto 2
if /I %odp% equ q goto q
goto help

:1
cls
echo Wyświetlenie nazw sieci i haseł:
echo.
setlocal enabledelayedexpansion
for /f "tokens=2 delims=:" %%a in ('netsh wlan show profile ^|findstr ":"') do (
    set "ssid=%%~a"
    call :getpwd "%%ssid:~1%%"
)
:getpwd

set "ssid=%*"
for /f "tokens=2 delims=:" %%i in ('netsh wlan show profile name^="%ssid:"=%" key^=clear ^| findstr /C:"Key Content"') do echo Nazwa sieci: %ssid%  hasło: %%i
echo.
echo To już wszystkie profile.
pause
goto menu

:2
cls
echo Eksport profili i haseł do pliku XML.
netsh wlan export profile folder=C:\ key=clear | findstr Key
echo Eksport został wykonany.
pause
goto menu

:help
cls
goto menu


:q
cls
echo Wychodzę z programu.
timeout /t 03
exit