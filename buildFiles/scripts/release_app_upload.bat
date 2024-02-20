rem zips and uploads Windows Standalone

echo %build% %version%

echo "==========UPLOADING STANDALONE WINDOWS========="

dir /s *.* > %HOMEDRIVE%%HOMEPATH%\Documents\artifacts\dirlisting_uploadbat.txt

rem MOVED TO CALLING SCRIPT
rem %sevenzip% a %HOMEPATH%\Documents\%appName%.zip *

rem preinstalled curl in Windows Server doesn't support SFTP protocol
rem %curl% -u %UPLOAD_USER%:%UPLOAD_PASSWORD% -T %HOMEPATH%\Documents\%appName%.zip %uploadURL%
rem try with choco installed curl instead

set myStructURL=%uploadURL%%version%/%build%/%appName%.zip
echo %myStructURL%

C:\ProgramData\chocolatey\bin\curl.exe -s -k -u %UPLOAD_USER%:%UPLOAD_PASSWORD% --ftp-create-dirs -T %HOMEPATH%\Documents\%appName%.zip %myStructURL%

echo UPLOAD DONE !!!!!!
