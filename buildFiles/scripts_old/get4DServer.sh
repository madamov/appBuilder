#!/bin/bash

workingDirectory=$(pwd)
next_build=$(jq -r '.build' ./buildFiles/parameters.json)
thisBuildDestinationFolder=$HOME/Documents/$next_build
	
if [ -d $thisBuildDestinationFolder/4D\ Server.app ]; then
	echo "4D Server.app present"
else

	echo "🐚:🐚: Downloading 4D Server..."

	# download 4D Server and leave it in thisBuildDestinationFolder
	curl -s -o $thisBuildDestinationFolder/4D_Server.zip $1
	echo "🐚:🐚: 4D Server $1 downloaded, unzipping archive ..."
	unzip -q $thisBuildDestinationFolder/4D_Server.zip -d $thisBuildDestinationFolder/
	echo "🐚🐚:: 4D Server unzipped"

fi
