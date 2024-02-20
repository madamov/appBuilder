rem batch file resembles main.yml in GitHub action runner to run test on local machine or VM

rem get jq for Windows from https://stedolan.github.io/jq/download/
rem move it to Documents\builderMainFolder folder and rename jq-64.exe to jq.exe
rem get curl for Windows from https://curl.se/windows/, extract it, rename folder to curl and move it to Document\builderMainFolder
rem get 7zip for Windows command line from https://www.7-zip.org/a/7z2201-extra.7z or newer, extract it, rename folder to 7za and move it to Documents\builderMainFolder

rem following line is for faster debugging in VM, not needed in Github actions
rem set mainyml=C:\Users\madamov\Documents\builderMainFolder\builderDemo\my4DApp\buildFiles\scripts\local_mainyml.bat

rem echo off

mkdir %HOMEDRIVE%%HOMEPATH%\Documents\artifacts

set myscript=%HOMEDRIVE%%HOMEPATH%\Documents\builderMainFolder\builderDemo\my4DApp\buildFiles\scripts\local_mainyml.bat

set jq=%HOMEDRIVE%%HOMEPATH%\Documents\builderMainFolder\jq.exe
set curl=%HOMEDRIVE%%HOMEPATH%\Documents\builderMainFolder\curl\bin\curl.exe
set sevenzip=%HOMEDRIVE%%HOMEPATH%\Documents\builderMainFolder\7za\7za.exe

set GITHUB_WORKSPACE=%HOMEDRIVE%%HOMEPATH%\Documents\builderMainFolder\builderDemo

set workingDirectory=%GITHUB_WORKSPACE%\my4DApp
set scripts=%workingDirectory%\buildFiles\scripts
set params=%workingDirectory%\buildFiles\parameters.json

set RUNNER_ACTOR=madamov
set RUNNER=LOCAL


set STATUSFILE=%HOMEDRIVE%%HOMEPATH%\Documents\artifacts\status.log

for /f %%i in ('%jq% -r .WHO_TO_TRUST %HOMEDRIVE%%HOMEPATH%\Documents\builderMainFolder\usernames.json') do set WHO_TO_TRUST=%%i
for /f %%i in ('%jq% -r .BINARIES_USER %HOMEDRIVE%%HOMEPATH%\Documents\builderMainFolder\usernames.json') do set BINARIES_USER=%%i
for /f %%i in ('%jq% -r .BINARIES_PASSWORD %HOMEDRIVE%%HOMEPATH%\Documents\builderMainFolder\usernames.json') do set BINARIES_PASSWORD=%%i
for /f %%i in ('%jq% -r .UPLOAD_USER %HOMEDRIVE%%HOMEPATH%\Documents\builderMainFolder\usernames.json') do set UPLOAD_USER=%%i
for /f %%i in ('%jq% -r .UPLOAD_PASSWORD %HOMEDRIVE%%HOMEPATH%\Documents\builderMainFolder\usernames.json') do set UPLOAD_PASSWORD=%%i

rem set current directory to one where repository is
cd %HOMEDRIVE%%HOMEPATH%\Documents\builderMainFolder\builderDemo\my4DApp


rem we build only from main branch, uncomment for production
rem git switch main


echo =================== DONE INITIALIZING STUFF ==============================

@call %scripts%\build_all.bat

echo =================== DONE BUILDING ========================================

if not exist %STATUSFILE% (@call %scripts%\postBuild.bat)

echo =================== DONE POST BUILD TASKS ================================

rem clear env variables

set RUNNER_ACTOR=
set RUNNER=
set STATUSFILE=
set WHO_TO_TRUST=
set BINARIES_USER=
set BINARIES_PASSWORD=
set UPLOAD_USER=
set UPLOAD_PASSWORD=
set workingDirectory=
set myscript=
set GITHUB_WORKSPACE=
set params=
set jq=
set curl=
set sevenzip=
set scripts=
set userParams=
set url4dvl=
set url4dserver=
set url4d=
set destination=
set version=
set build=
set myStructURL=
