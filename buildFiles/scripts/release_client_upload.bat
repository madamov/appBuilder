rem zips and uploads Windows Client

echo "========== UPLOADING WINDOWS CLIENT ========="
echo %build% %version%

set myClientURL=%uploadURL%%version%/%build%/%appName%_client.zip
echo %myClientURL%

C:\ProgramData\chocolatey\bin\curl.exe -s -k -u %UPLOAD_USER%:%UPLOAD_PASSWORD% --ftp-create-dirs -T %HOMEPATH%\Documents\%appName%_client.zip %myClientURL%

echo "========== UPLOAD OF CLIENT DONE !!!!!!| =========="
