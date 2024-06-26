rem set all env variables

set workingDirectory=%GITHUB_WORKSPACE%
set scripts=%workingDirectory%\buildFiles\scripts
set params=%workingDirectory%\buildFiles\parameters.json

set STATUSFILE=%HOMEDRIVE%%HOMEPATH%\Documents\artifacts\status.log

for /f %%i in ('%jq% -r .actionWin %params%') do set action=%%i
for /f %%i in ('%jq% -r .buildDestinationFolder %params%') do set destination=%%i

set build=%REPO_BUILD_NUMBER%
set version=%REPO_VERSION%

for /f %%i in ('%jq% -r .repo %params%') do set repoURL=%%i
for /f %%i in ('%jq% -r .uploadWinStandalone %params%') do set uploadURL=%%i
for /f %%i in ('%jq% -r .uploadWinServer %params%') do set uploadServerURL=%%i
for /f %%i in ('%jq% -r .appName %params%') do set appName=%%i

set destFolder=%HOMEDRIVE%%HOMEPATH%\Documents\%destination%
