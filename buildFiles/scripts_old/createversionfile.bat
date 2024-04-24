rem jq -n --arg jq_version "$version" --arg jq_build "$oldbuild" --arg jq_url "$url" --arg jq_updateurl "$versionURL" '{"version":$jq_version, "buildNumber":$jq_build, "URL":$jq_updateurl, "UpdateURL":$jq_url}' > $HOME/version.json

%jq% -n --arg jq_version "%REPO_VERSION%" --arg jq_build "%REPO_BUILD_NUMBER%" '{"version":$jq_version,"buildNumber":$jq_build}' > %HOMEPATH%version.json

dir %HOMEPATH% > C:\Users\runneradmin\Documents\artifacts\dirlist.txt

echo %HOMEPATH%

type %HOMEPATH%version.json

cp %HOMEPATH%version.json C:\Users\runneradmin\Documents\artifacts\version.json
