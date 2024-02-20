#!/bin/bash

# script uploads/publish built files/makes releases

workingDirectory=$(pwd)
next_build=$(jq -r '.build' ./buildFiles/parameters.json)
destinationFolder=$HOME/Documents/$next_build

echo "🐚🐚:: Starting postBuild script ..."

destination=$(jq -r '.buildDestinationFolder' $workingDirectory/buildFiles/parameters.json)
build=$(jq -r '.build' $workingDirectory/buildFiles/parameters.json)
destFolder=$destinationFolder/${destination}
version=$(jq -r '.version' $workingDirectory/buildFiles/parameters.json)
action=$(jq -r '.actionMac' $workingDirectory/buildFiles/parameters.json)

echo "Destination path from parameters.json: $destination"
echo "destFolder: $destFolder"

ls -alR $HOME/Documents > $destinationFolder/artifacts/all_listing.txt

if [[ $action == *"BUILD_COMPILED_STRUCTURE"* ]]; then
	/bin/bash $workingDirectory/buildFiles/scripts/release_structure.sh $destFolder $build $version
fi

if [[ $action == *"BUILD_APP"* ]]; then
	/bin/bash $workingDirectory/buildFiles/scripts/release_app.sh $destFolder $build $version
fi
