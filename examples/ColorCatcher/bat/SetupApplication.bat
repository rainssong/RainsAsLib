:user_configuration

:: About AIR application packaging
:: http://livedocs.adobe.com/flex/3/html/help.html?content=CommandLineTools_5.html#1035959
:: http://livedocs.adobe.com/flex/3/html/distributing_apps_4.html#1037515

:: NOTICE: all paths are relative to project root

:: Android packaging
set AND_CERT_NAME="ColorCatcher"
set AND_CERT_PASS=fd
set AND_CERT_FILE=cert\ColorCatcher.p12
set AND_ICONS=icons/android

set AND_SIGNING_OPTIONS=-storetype pkcs12 -keystore "%AND_CERT_FILE%" -storepass %AND_CERT_PASS%

:: iOS packaging
set IOS_DIST_CERT_FILE=cert\edoctor.p12
set IOS_DEV_CERT_FILE=cert\edoctor.p12
set IOS_DEV_CERT_PASS=123
set IOS_PROVISION=cert\Anything.mobileprovision
set IOS_ICONS=icons\

set IOS_DEV_SIGNING_OPTIONS=-storetype pkcs12 -keystore "%IOS_DEV_CERT_FILE%" -storepass %IOS_DEV_CERT_PASS% -provisioning-profile %IOS_PROVISION%
set IOS_DIST_SIGNING_OPTIONS=-storetype pkcs12 -keystore "%IOS_DIST_CERT_FILE%" -storepass %IOS_DEV_CERT_PASS% -provisioning-profile %IOS_PROVISION%

:: Application descriptor
set APP_XML=application.xml

:: Files to package
set APP_DIR=bin
set EXT_DIR=lib
set EXT_FOLDER_DIR=ext-folder
set FILE_OR_DIR=-C %APP_DIR% .

:: Your application ID (must match <id> of Application descriptor)
for /f "tokens=2 delims=>" %%i in ('findstr "<id>" %APP_XML%') do (
	for /f "delims=<" %%i in ("%%i")do (
		set APP_ID=%%i
	)
)

:: Version
for /f "tokens=2 delims=>" %%i in ('findstr "<versionNumber>" %APP_XML%') do (
	for /f "delims=<" %%i in ("%%i")do (
		set VERSION=%%i
	)
)

:: Output packages
set DIST_PATH=bin-release
set DIST_NAME=ColorCatcher

:: Debugging using a custom IP
set DEBUG_IP=



:validation
%SystemRoot%\System32\find /C "<id>%APP_ID%</id>" "%APP_XML%" > NUL
if errorlevel 1 goto badid
goto end

:badid
echo.
echo ERROR: 
echo   Application ID in 'bat\SetupApplication.bat' (APP_ID) 
echo   does NOT match Application descriptor '%APP_XML%' (id)
echo.

:end