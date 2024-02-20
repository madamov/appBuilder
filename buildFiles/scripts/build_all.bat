for /f %%i in ('%jq% -r .actionWin %params%') do set action=%%i

rem install curl with support for SFTP protocol
choco install -no-progress -y curl

rem install gdrive to upload to Google Drive
rem choco install -no-progress gdrive

for /f %%i in ('%jq% -r .winlicenses_URL %params%') do set urllicenses=%%i

@call %scripts%\licenses.bat %urllicenses%
set urllicenses=

echo downloading 4D

for /f %%i in ('%jq% -r .win4D_URL %params%') do set url4d=%%i
@call %scripts%\get4D.bat %url4d%


rem always download Volume Desktop, look at @call getVD_on_action.bat to see how it
rem is supposed to be implemented, but env variable is not set properly

for /f %%j in ('%jq% -r .winVL_URL %params%') do set getvd=%%j
@call %scripts%\get4DVL.bat %getvd%


if not x%action:BUILD_SERVER=%==x%action% (
	for /f %%i in ('%jq% -r .winServer_URL %params%') do set url4dserver=%%i
	@call %scripts%\get4DServer.bat %url4dserver%
)


SETLOCAL EnableDelayedExpansion
for /f "Tokens=* Delims=" %%x in (%params%) do set userParams=!userParams!%%x


for /f %%i in ('powershell -command "$bytes = [System.IO.File]::ReadAllBytes('%params%'); [Convert]::ToBase64String($bytes)"') do set b64=%%i


%HOMEDRIVE%%HOMEPATH%\Documents\4D\4D\4D.exe --headless --dataless --project %workingDirectory%\Project\CXR7.4DProject --user-param "%b64%"
