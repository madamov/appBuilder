REM Batch file to release standalone Windows app

rem switch to HOMEDRIVE, sometimes repo is cloned on drive D:
%HOMEDRIVE%

cd %destFolder%
dir /s *.* > %HOMEDRIVE%%HOMEPATH%\Documents\artifacts\dirlisting_releaseapp.txt

cd "Final Application"
cd %appName%

rem If you have some files tha need to be next to a structure (how we used to call it before Project mode)
rem xcopy %GITHUB_WORKSPACE%\WebFolder Database\WebFolder /E /Y /I /F


echo "Releasing Windows standalone app"
echo "Repo for standalone app is %repoURL%"

IF DEFINED uploadURL (set zipme=ok)
IF DEFINED repoURL (set zipme=ok)

if [%zipme%] == [ok] (%sevenzip% a %HOMEPATH%\Documents\%appName%.zip *)

IF DEFINED uploadURL (@call %scripts%\release_app_upload.bat)

IF DEFINED repoURL (@call %scripts%\release_app_gh.bat %1% %2% %3%)

set zipme=
