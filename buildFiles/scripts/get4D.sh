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

	curl -s -o $HOME/Downloads/4D.zip $myurl
	# curl -o $HOME/Downloads/4D.zip $myurl

	echo "🐚:🐚: $1 4D downloaded, unzipping archive ..."
	# unzip -q $HOME/Documents/4D.zip -d $HOME/Documents/
	unzip -q $HOME/Downloads/4D.zip -d $HOME/Downloads/
	echo "🐚🐚:: 4D unzipped"

	# copy it to Applications folder
	cp -R $HOME/Downloads/4D.app /Applications/4D.app
		
fi
