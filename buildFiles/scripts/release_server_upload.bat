rem zips and uploads Windows Server

echo %build% %version%

echo "========== UPLOADING WINDOWS SERVER ========="

set myServerURL=%uploadURL%%version%/%build%/%appName%_server.zip
echo %myServerURL%

C:\ProgramData\chocolatey\bin\curl.exe -s -k -u %UPLOAD_USER%:%UPLOAD_PASSWORD% --ftp-create-dirs -T %HOMEPATH%\Documents\%appName%_server.zip %myServerURL%

echo "========== UPLOAD OF SERVER DONE !!!!!! =========="
