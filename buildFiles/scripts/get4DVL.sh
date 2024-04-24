#!/bin/bash

# download 4D Volume Desktop, leave it in Documents folder, we will refer to it in buildApp.4DSettings XML file

workingDirectory=$(pwd)

myurl=$(echo $1 | sed 's/https:\/\//&'"$BINARIES_USER:$BINARIES_PASSWORD@/")

echo "🐚:🐚: Downloading 4D Volume Desktop ..."
curl -s -o $HOME/Documents/4D_VL.zip $myurl
echo "🐚:🐚: 4D Volume Desktop $1 downloaded, unzipping archive ..."
unzip -q $HOME/Documents/4D_VL -d $HOME/Documents/
echo "🐚:🐚: 4D Volume Desktop unzipped"
