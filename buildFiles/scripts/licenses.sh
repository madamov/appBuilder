#!/bin/bash

# script downloads licenses, expands them and copies them so 
# 4D will run as Development Professional allowing us to compile and build

workingDirectory=$(pwd)

myurl=$(echo $1 | sed 's/https:\/\//&'"$BINARIES_USER:$BINARIES_PASSWORD@/")

echo $myurl

curl -s -o $HOME/Documents/dev_lic.zip $myurl
# curl -o $HOME/Documents/dev_lic.zip $myurl

# ls -al $HOME/Documents/

echo "🐚:🐚:: Licenses downloaded"

if [ -d "$HOME/Documents/Licenses" ]; then
	echo "🐚:🐚:: Licenses in Documents exists"
else
	mkdir $HOME/Documents/Licenses
	echo "🐚:🐚:: Created Licenses folder in Documents folder"
fi

# extract licenses from archive
unzip -j $HOME/Documents/dev_lic.zip -d $HOME/Documents/Licenses/

if [ -d "$HOME/Library/Application support/4D" ]; then
	echo "🐚:🐚:: 4D folder exists"
else 
	mkdir "$HOME/Library/Application support/4D"
	echo created Application support 4D folder
fi

if [ -d "$HOME/Library/Application support/4D/Licenses" ]; then
	echo "🐚:🐚:: Licenses folder exists"
else 
	mkdir "$HOME/Library/Application Support/4D/Licenses"
	echo created license folder
fi

# copy licenses so 4D is licensed as Developer Professional
# leave originals in Documents folder, we will refer to them in buildApp.4DSettings XML file
cp $HOME/Documents/Licenses/* $HOME/Library/Application\ Support/4D/Licenses/
echo "🐚:🐚:: Licenses copied to " $HOME/Library/Application\ Support/4D/Licenses/
