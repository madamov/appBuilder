REM Batch file to release Windows Server

echo "++++++++++++ Releasing Windows Server +++++++++++++++++"

rem copy files nxt to a structure file into Server Database folder
rem xcopy %GITHUB_WORKSPACE%\WebFolder "%destFolder%\Client Server executable\%appName% Server\Server Database\WebFolder" /E /Y /I /F

dir /s %destFolder%\*.* > %HOMEDRIVE%%HOMEPATH%\Documents\artifacts\dirlisting_serveruploadbat.txt

IF DEFINED uploadURL (set zipme=ok)

if [%zipme%] == [ok] (%sevenzip% a %HOMEPATH%\Documents\%appName%_server.zip "%destFolder%\Client Server executable\%appName% Server\*")

IF DEFINED uploadURL (@call %scripts%\release_server_upload.bat)

set zipme=

echo "++++++++++++ End Releasing Windows Server +++++++++++++++++"
