#!/bin/bash

# download 4D Volume Desktop, leave it in Documents folder, we will refer to it in buildApp.4DSettings XML file

workingDirectory=$(pwd)
next_build=$(jq -r '.build' ./buildFiles/parameters.json)
destinationFolder=$HOME/Documents/$next_build

myurl=$(echo $1 | sed 's/https:\/\//&'"$BINARIES_USER:$BINARIES_PASSWORD@/")

echo "🐚:🐚: Downloading 4D Volume Desktop ..."
curl -s -o $destinationFolder/4D_VL.zip $myurl
echo "🐚:🐚: 4D Volume Desktop $1 downloaded, unzipping archive ..."
unzip -q $destinationFolder/4D_VL -d $destinationFolder/
echo "🐚:🐚: 4D Volume Desktop unzipped"
