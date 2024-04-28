#!/bin/bash

workingDirectory=$(pwd)

destinationFolder=$1
macAction=$2

appName=$(jq -r '.appName' $workingDirectory/buildFiles/parameters.json)

# if we built the server, archive is already in application package
# if we don't need macOS server, but we do need macOS client in Windows server, archive is
# directly in client server build destination folder

if [[ $macAction == *"BUILD_SERVER"* ]]; then
	archivePath=$destinationFolder/Server/${appName}\ Server.app/Contents/Upgrade4DClient/update.mac.4darchive
	cp $destinationFolder/Server/${appName}\ Server.app/Contents/Upgrade4DClient/update.mac.4darchive $HOME/Documents/update.mac.4darchive
else
	archivePath=$destinationFolder/Client\ Server\ executable/Upgrade4DClient/update.mac.4darchive
	cp $destinationFolder/Client\ Server\ executable/Upgrade4DClient/update.mac.4darchive $HOME/Documents/update.mac.4darchive
fi

# copy it to location easily pickable by next step in macOS job
# cp $archivePath $HOME/Documents/update.mac.4darchive

# tell uploading step there is something to upload
echo "pass_mac_client=true" >> $GITHUB_ENV   

# tell windows runner we actually uploaded the file
echo "passed=OK" >> "$GITHUB_OUTPUT"
