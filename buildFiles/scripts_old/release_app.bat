REM Batch file to release standalone Windows app

rem cd %1%
rem cd "Final Application"

rem switch to HOMEDRIVE, sometimes repo is cloned on drive D:
%HOMEDRIVE%

cd %destFolder%
dir /s *.* > %HOMEDRIVE%%HOMEPATH%\Documents\%nextbuildnumber%\artifacts\dirlisting_releaseapp.txt

cd "Final Application"
cd %appName%


echo "Releasing Windows standalone app"
echo "Repo for standalone app is %repoURL%"

IF DEFINED uploadURL (set zipme=ok)
IF DEFINED repoURL (set zipme=ok)

if [%zipme%] == [ok] (%sevenzip% a %HOMEPATH%\Documents\%nextbuildnumber%\%appName%.zip *)

IF DEFINED uploadURL (@call %scripts%\release_app_upload.bat)

IF DEFINED repoURL (@call %scripts%\release_app_gh.bat %1% %2% %3%)

set zipme=
