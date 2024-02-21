#!/bin/bash

if [ -d /Applications/4D.app ]; then
	echo "4D.app present"
else

	workingDirectory=$(pwd)
#	next_build=$(jq -r '.build' ./buildFiles/parameters.json)
#	thisBuildDestinationFolder=$HOME/Documents/$next_build

#	echo destination folder is:
#	echo $thisBuildDestinationFolder

	myurl=$(echo $1 | sed 's/https:\/\//&'"$BINARIES_USER:$BINARIES_PASSWORD@/")

	echo "🐚:🐚: Downloading 4D ..."

	# curl -s -o $HOME/Documents/4D.zip $myurl

	# curl -s -o $thisBuildDestinationFolder/4D.zip $myurl
	curl -o $thisBuildDestinationFolder/4D.zip $myurl

	echo "🐚:🐚: $1 4D downloaded, unzipping archive ..."
	# unzip -q $HOME/Documents/4D.zip -d $HOME/Documents/
	unzip -q $thisBuildDestinationFolder/4D.zip -d $thisBuildDestinationFolder/
	echo "🐚🐚:: 4D unzipped"

	# copy it to Applications folder
	cp -R $thisBuildDestinationFolder/4D.app /Applications/4D.app

fi
