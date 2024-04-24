#!/bin/bash

workingDirectory=$(pwd)

# where to upload version.json?
versionUploadURL=$(jq -r '.versionFileUploadURL' $workingDirectory/buildFiles/parameters.json)

jq -n --arg jq_version "$REPO_VERSION" --arg jq_build "$REPO_BUILD_NUMBER" --arg jq_url "$url" --arg jq_updateurl "$versionURL" '{"version":$jq_version, "buildNumber":$jq_build, "URL":$jq_updateurl, "UpdateURL":$jq_url}' > $HOME/version.json
