#!/bin/bash

# download 4D Volume Desktop, leave it in Documents folder, we will refer to it in buildApp.4DSettings XML file

myurl=$(echo $1 | sed 's/https:\/\//&'"$BINARIES_USER:$BINARIES_PASSWORD@/")

echo "🐚:🐚: Downloading 4D Volume Desktop ..."
curl -o $HOME/Downloads/4D_VL.zip $myurl

echo "🐚:🐚: 4D Volume Desktop $1 downloaded, unzipping archive ..."
unzip -q $HOME/Downloads/4D_VL -d $HOME/Documents
echo "🐚:🐚: 4D Volume Desktop unzipped"
