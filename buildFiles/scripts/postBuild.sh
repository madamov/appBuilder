#!/bin/bash

# script uploads/publish built files/makes releases

workingDirectory=$(pwd)

echo "🐚🐚:: Starting postBuild script ..."

destination=$(jq -r '.buildDestinationFolder' $workingDirectory/buildFiles/parameters.json)
build=$REPO_BUILD_NUMBER
destFolder=$HOME/Documents/${destination}
version=$REPO_VERSION
action=$(jq -r '.actionMac' $workingDirectory/buildFiles/parameters.json)
actionWin=$(jq -r '.actionWin' $workingDirectory/buildFiles/parameters.json)

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

if [[ $action == *"INCLUDE_CLIENT"* ]] && [[ $actionWin == *"INCLUDE_MAC_CLIENT"* ]]; then
	/bin/bash $workingDirectory/buildFiles/scripts/pass_client_to_win_runner.sh $destFolder $action
fi

ls -al $HOME/Documents > $HOME/Documents/artifacts/after_app_build_listing.txt
ls -alR $destFolder > $HOME/Documents/artifacts/after_app_build_destinationfolderonly.txt

# workaround for downloading missing macos client archive artifact in WIndows runner
# create dummy file at particular destination if $HOME/Documents/update.mac.4darchive doesn't exists

if [[ -f "$HOME/Documents/update.mac.4darchive" ]]; then
	echo "$HOME/Documents/update.mac.4darchive already exists"
else
	echo $action > $HOME/Documents/update.mac.4darchive
	echo $actionWin >> $HOME/Documents/update.mac.4darchive
fi
