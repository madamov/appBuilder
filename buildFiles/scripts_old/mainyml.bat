mkdir %HOMEDRIVE%%HOMEPATH%\Documents\artifacts


rem set env vars to comply with local_mainyml.bat so all the scripts have the same aliases

set jq=jq
set curl=curl
set sevenzip=7z

rem set env vars used in all batch files
@call %GITHUB_WORKSPACE%\buildFiles\scripts\setenvvars.bat

for /f %%i in ('%jq% -r .actionWin %params%') do set action=%%i

rem we build only from main branch, uncomment for production
rem git switch main

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
