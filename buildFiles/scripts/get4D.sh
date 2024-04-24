#!/bin/bash

workingDirectory=$(pwd)

myurl=$(echo $1 | sed 's/https:\/\//&'"$BINARIES_USER:$BINARIES_PASSWORD@/")

echo "🐚:🐚: Downloading 4D ..."

curl -s -f -o $HOME/Documents/4D.zip $myurl

echo "🐚:🐚: $1 4D downloaded, unzipping archive ..."
unzip -q $HOME/Documents/4D.zip -d $HOME/Documents/
echo "🐚🐚:: 4D unzipped"

# copy it to Applications folder
cp -R $HOME/Documents/4D.app /Applications/4D.app
