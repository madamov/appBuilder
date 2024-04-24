mkdir %HOMEDRIVE%%HOMEPATH%\Documents\artifacts

echo created artifacts

set jq=jq
set curl=curl
set sevenzip=7z

rem set env vars used in all batch files
@call %GITHUB_WORKSPACE%\buildFiles\scripts\setenvvars.bat
echo env vars set

echo {"version":"%REPO_VERSION%","buildNumber":%REPO_BUILD_NUMBER%} > %HOMEDRIVE%%HOMEPATH%\Documents\artifacts\version_test.json
copy /y %HOMEDRIVE%%HOMEPATH%\Documents\artifacts\version_test.json Resources\version.json
dir Resources\ > %HOMEDRIVE%%HOMEPATH%\Documents\artifacts\reslist.txt
echo version.json copied to Resources

cat Resources\version.json
cat %HOMEDRIVE%%HOMEPATH%\Documents\artifacts\version_test.json

echo {"version":"%REPO_VERSION%","buildNumber":%REPO_BUILD_NUMBER%} > %HOMEDRIVE%%HOMEPATH%\Documents\artifacts\version_test.json
copy /y %HOMEDRIVE%%HOMEPATH%\Documents\artifacts\version_test.json Resources\version.json
dir Resources\ > %HOMEDRIVE%%HOMEPATH%\Documents\artifacts\reslist.txt
echo version.json copied to Resources

for /f %%i in ('%jq% -r .actionWin %params%') do set action=%%i

echo got action from paramaters.json

IF NOT DEFINED action GOTO skipall

if [%action%] == [null] GOTO skip_null

echo =================== DONE INITIALIZING STUFF ==============================

@call %scripts%\build_all.bat

echo =================== DONE BUILDING ========================================

if not exist %STATUSFILE% (@call %scripts%\postBuild.bat)

echo =================== DONE POST BUILD TASKS ================================
echo


rem list env vars to output for debugging
set

powershell -command "Get-EventLog -LogName System -EntryType Error" > %HOMEDRIVE%%HOMEPATH%\Documents\artifacts\eventlog.txt

GOTO :EOF

:skip_null

echo "action is null"

:skipall

echo "SKIPPED EVERYTHING!!!"

GOTO :EOF
