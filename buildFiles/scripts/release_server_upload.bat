rem zips and uploads Windows Server


echo "========== UPLOADING WINDOWS SERVER ========="
echo %build% %version%

set myServerURL=%uploadServerURL%%version%/%build%/%appName%_server.zip
echo %myServerURL%

C:\ProgramData\chocolatey\bin\curl.exe -s -k -u %UPLOAD_USER%:%UPLOAD_PASSWORD% --ftp-create-dirs -T %HOMEPATH%\Documents\%appName%_server.zip %myServerURL%

echo "========== UPLOAD OF SERVER DONE !!!!!! =========="
