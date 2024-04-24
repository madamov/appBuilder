rem install curl with support for SFTP protocol
choco install -no-progress -y curl

cp C:\ProgramData\chocolatey\logs\chocolatey.log %HOMEPATH%\artifacts\chocolatey.log

for /f %%i in ('%jq% -r .winlicenses_URL %params%') do set urllicenses=%%i

@call %scripts%\licenses.bat %urllicenses%
set urllicenses=

echo downloading 4D

for /f %%i in ('%jq% -r .win4D_URL %params%') do set url4d=%%i
@call %scripts%\get4D.bat %url4d%


rem always download Volume Desktop

for /f %%j in ('%jq% -r .winVL_URL %params%') do set getvd=%%j
@call %scripts%\get4DVL.bat %getvd%

for /f %%k in ('%jq% -r .winServer_URL %params%') do set url4dserver=%%k

if not x%action:BUILD_SERVER=%==x%action% (
	echo "%url4dserver%"
	@call %scripts%\get4DServer.bat %url4dserver%
)


SETLOCAL EnableDelayedExpansion
for /f "Tokens=* Delims=" %%x in (%params%) do set userParams=!userParams!%%x


for /f %%i in ('powershell -command "$bytes = [System.IO.File]::ReadAllBytes('%params%'); [Convert]::ToBase64String($bytes)"') do set b64=%%i


%HOMEDRIVE%%HOMEPATH%\Documents\4D\4D\4D.exe --headless --dataless --project %workingDirectory%\Project\CXR7.4DProject --user-param "%b64%"
