REM Batch file to release Windows Server

rem cd %destFolder%
rem cd
rem cd "Client Server executable\%appName% Server"

rem xcopy %GITHUB_WORKSPACE%\WebFolder "Server Database\WebFolder" /E /Y /I /F

xcopy %GITHUB_WORKSPACE%\WebFolder "%destFolder%\Client Server executable\%appName% Server\Server Database\WebFolder" /E /Y /I /F

dir /s %destFolder%\*.* > %HOMEDRIVE%%HOMEPATH%\Documents\artifacts\dirlisting_serveruploadbat.txt

echo "Releasing Windows Server"

IF DEFINED uploadURL (set zipme=ok)

rem if [%zipme%] == [ok] (%sevenzip% a %HOMEPATH%\Documents\%appName%_server.zip *)
if [%zipme%] == [ok] (%sevenzip% a %HOMEPATH%\Documents\%appName%_server.zip "%destFolder%\Client Server executable\%appName% Server\*")

IF DEFINED uploadURL (@call %scripts%\release_server_upload.bat)

set zipme=
