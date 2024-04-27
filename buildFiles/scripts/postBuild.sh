#!/bin/bash

# script uploads/publish built files/makes releases

workingDirectory=$(pwd)

echo "🐚🐚:: Starting postBuild script ..."

echo making version.json file

destination=$(jq -r '.buildDestinationFolder' $workingDirectory/buildFiles/parameters.json)
build=$REPO_BUILD_NUMBER
destFolder=$HOME/Documents/${destination}
version=$REPO_VERSION
action=$(jq -r '.actionMac' $workingDirectory/buildFiles/parameters.json)

echo "Destination path from parameters.json: $destination"
echo "destFolder: $destFolder"

ls -alR $HOME/Documents > $HOME/Documents/artifacts/all_listing.txt

if [[ $action == *"BUILD_COMPILED_STRUCTURE"* ]]; then
	/bin/bash $workingDirectory/buildFiles/scripts/release_structure.sh $destFolder $build $version
fi

if [[ $action == *"BUILD_APP"* ]]; then
	/bin/bash $workingDirectory/buildFiles/scripts/release_app.sh $destFolder $build $version
fi

if [[ $action == *"BUILD_SERVER"* ]]; then
	/bin/bash $workingDirectory/buildFiles/scripts/release_server.sh $destFolder $build $version
fi

if [[ $action == *"BUILD_CLIENT"* ]]; then
	/bin/bash $workingDirectory/buildFiles/scripts/release_client.sh $destFolder $build $version
fi

ls -al $HOME/Documents > $HOME/Documents/artifacts/after_app_build_listing.txt
