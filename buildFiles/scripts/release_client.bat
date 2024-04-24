REM Batch file to release Windows Client

rem cd %destFolder%
rem cd "Client Server executable\%appName% Client"

dir /s *.* > %HOMEDRIVE%%HOMEPATH%\Documents\artifacts\dirlisting_clientuploadbat.txt

echo "Releasing Windows Client"

IF DEFINED uploadURL (set zipme=ok)

rem if [%zipme%] == [ok] (%sevenzip% a %HOMEPATH%\Documents\%appName%_client.zip *)
if [%zipme%] == [ok] (%sevenzip% a %HOMEPATH%\Documents\%appName%_client.zip "%destFolder%\Client Server executable\%appName% Client\*")

IF DEFINED uploadURL (@call %scripts%\release_client_upload.bat)

set zipme=
