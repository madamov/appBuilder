rem set all env variables

set jq=jq
set curl=curl
set sevenzip=7z

set myscript=%HOMEDRIVE%%HOMEPATH%\Documents\builderMainFolder\builderDemo\My4DApp\buildFiles\scripts\local_mainyml.bat

set workingDirectory=%GITHUB_WORKSPACE%
set scripts=%workingDirectory%\buildFiles\scripts
set params=%workingDirectory%\buildFiles\parameters.json

set STATUSFILE=%HOMEDRIVE%%HOMEPATH%\Documents\artifacts\status.log

for /f %%i in ('%jq% -r .actionWin %params%') do set action=%%i
for /f %%i in ('%jq% -r .version %params%') do set version=%%i
for /f %%i in ('%jq% -r .buildDestinationFolder %params%') do set destination=%%i
rem for /f %%i in ('%jq% -r .build %params%') do set build=%%i

set build=%REPO_BUILD_NUMBER%

REM for /f %%i in ('%jq% -r .repoWinStandalone %params%') do set repoURL=%%i
for /f %%i in ('%jq% -r .repo %params%') do set repoURL=%%i
for /f %%i in ('%jq% -r .uploadWinStandalone %params%') do set uploadURL=%%i
for /f %%i in ('%jq% -r .appName %params%') do set appName=%%i

echo build is %build%
echo workingDirectory is %workingDirectory%
echo scripts is %scripts%

          (
            echo { 
            echo   "name": "John Doe", 
            echo   "age": 30, 
            echo   "city": "New York" 
            echo }
           ) > %HOMEPATH%\artifacts\data1.json

echo {"ime":"Milan","prezime":"Adamov"} > %HOMEPATH%\artifacts\miki.json
