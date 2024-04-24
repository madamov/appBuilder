rem commits, pushes and creates github release of windows standalone

echo jedan
echo %1%
echo dva
echo %2%
echo tri
echo %3%

if [%repoURL%] == [null] GOTO isNULL

mkdir %HOMEPATH%\Documents\app_repo
del /s /q %HOMEPATH%\Documents\app_repo\*.*

rem WHO_TO_TRUST is secret in environment variable set in main.yml jobs section as first thing before everything
rem RUNNER_ACTOR is also set in main.yml

git clone https://%RUNNER_ACTOR%:%WHO_TO_TRUST%@%repoURL% %HOMEPATH%\Documents\app_repo\



rem echo "CMD : Making release of windows standalone app ..."
rem echo "CMD: Copying files ..."
rem xcopy /Y /S /E *.* %HOMEPATH%\Documents\app_repo\*.*
rem echo CMD : End copying to standalone release repository ..."

cd %HOMEPATH%\Documents\app_repo
dir /s *.* > %HOMEDRIVE%%HOMEPATH%\Documents\artifacts\dirlisting_apprepo.txt

rem echo %WHO_TO_TRUST% | gh auth login --with-token
gh auth login --with-token

echo %RELEASE_TAG% from macOS

IF [%RELEASE_TAG%] == [none] (
	git add .
	git commit -m "Releasing version %3% build %2% of Windows standalone app"
	git push -q
	gh release create "%releasetag%" --notes "Release %3% build %2%"
	gh release upload "%releasetag%" "HOMEPATH%\Documents\%appName%.zip"
	) ELSE (
	rem release tag is coming from macOS runner
	echo DOING GH UPLOAD
	gh release upload "%RELEASE_TAG%" "%HOMEPATH%\Documents\%appName%.zip"
	)

cd %workingDirectory%

:isNULL

GOTO :EOF
