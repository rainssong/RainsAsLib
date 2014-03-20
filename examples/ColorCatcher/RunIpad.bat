@echo off
set PAUSE_ERRORS=1
call bat\SetupSDK.bat
call bat\SetupApplication.bat

:target
goto desktop

:desktop
:: http://help.adobe.com/en_US/air/build/WSfffb011ac560372f-6fa6d7e0128cca93d31-8000.html

set SCREEN_SIZE=iPad

:desktop-run
echo.
echo Starting AIR Debug Launcher with screen size '%SCREEN_SIZE%'

adl -screensize %SCREEN_SIZE% "%APP_XML%" "%APP_DIR%" -extdir "%EXT_FOLDER_DIR%"
if errorlevel 1 goto error
goto end

:error
pause

:end