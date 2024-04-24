REM Batch file to release standalone Windows app

rem cd %1%
rem cd "Final Application"

rem switch to HOMEDRIVE, sometimes repo is cloned on drive D:
%HOMEDRIVE%

cd %destFolder%
dir /s *.* > %HOMEDRIVE%%HOMEPATH%\Documents\artifacts\dirlisting_releaseapp.txt

cd "Final Application"
cd %appName%

rem xcopy %GITHUB_WORKSPACE%\Flags_Exported Database\Flags_Exported /E /Y /I
xcopy %GITHUB_WORKSPACE%\WebFolder Database\WebFolder /E /Y /I /F


echo "Releasing Windows standalone app"
echo "Repo for standalone app is %repoURL%"

IF DEFINED uploadURL (set zipme=ok)
IF DEFINED repoURL (set zipme=ok)

if [%zipme%] == [ok] (%sevenzip% a %HOMEPATH%\Documents\%appName%.zip *)

IF DEFINED uploadURL (@call %scripts%\release_app_upload.bat)

IF DEFINED repoURL (@call %scripts%\release_app_gh.bat %1% %2% %3%)

set zipme=
