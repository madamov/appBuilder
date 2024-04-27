#!/bin/bash

workingDirectory=$(pwd)

myurl=$(echo $1 | sed 's/https:\/\//&'"$BINARIES_USER:$BINARIES_PASSWORD@/")

echo "🐚:🐚: Downloading 4D ..."
# download 4D
curl -s -f -o $HOME/Documents/4D_Server.zip $myurl
echo "🐚:🐚: 4D Server $1 downloaded, unzipping archive ..."
unzip -q $HOME/Documents/4D_Server.zip -d $HOME/Documents/
echo "🐚🐚:: 4D Server unzipped"
