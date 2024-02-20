#!/bin/bash

echo "Start of build: "
date

workingDirectory=$(pwd)
pwd

# disable Gatekeeper and application translocating, may save us some processing cycles
sudo spctl --master-disable
echo "SCRIPT: macOS Gatekeeper disabled"

# following works only when booted from Recovery partition
#csrutil disable
#echo "SIP disabled"


# download developer licenses archive
curl -s -o $HOME/Documents/dev_v19_mac.zip https://www.adamov.co.rs/cxr/dev_v19_mac.zip
echo "SCRIPT: Licenses downloaded"

if [ -d "$HOME/Documents/Licenses" ]; then
	echo "SCRIPT: Licenses in Documents exists"
else
	mkdir $HOME/Documents/Licenses
	echo "SCRIPT: Created Licenses folder in Documents folder"
fi

# extract licenses from archive
unzip $HOME/Documents/dev_v19_mac.zip -d $HOME/Documents/Licenses/

if [ -d "$HOME/Library/Application support/4D" ]; then
	echo "SCRIPT: 4D folder exists"
else 
	mkdir "$HOME/Library/Application support/4D"
fi

if [ -d "$HOME/Library/Application support/4D/Licenses" ]; then
	echo "SCRIPT: Licenses folder exists"
else 
	mkdir "$HOME/Library/Application Support/4D/Licenses"
fi

# copy licenses so 4D is licensed as Developer Professional
# leave originals in Documents folder, we will refer to them in buildApp.4DSettings XML file
cp $HOME/Documents/Licenses/* $HOME/Library/Application\ Support/4D/Licenses/
echo "SCRIPT: Licenses copied to " $HOME/Library/Application\ Support/4D/Licenses/

echo "SCRIPT: Downloading 4D ..."
# download 4D and move it to /Applications folder
curl -s -o $HOME/Documents/4D_19_2.zip https://www.adamov.co.rs/cxr/4D_19_2_mac.zip
echo "SCRIPT: 4D v19.2 downloaded, unzipping archive ..."
unzip -q $HOME/Documents/4D_19_2.zip -d $HOME/Documents/
echo "SCRIPT: 4D unzipped"


compilerOptions="--dataless --headless"
# compiler="/Applications/4D.app/Contents/MacOS/4D"
compiler="$HOME/Documents/4D.app/Contents/MacOS/4D"
projectFile=$workingDirectory/Project/CXR7.4DProject


# run 4D and let 4D do the work
echo "SCRIPT: Starting 4D ..."
#"$compiler" $compilerOptions --project "$projectFile" --user-param "{\"action\":\"COMPILE_ONLY\"}"

# /Applications/4D.app/Contents/MacOS/4D --headless --dataless --project "Project/CXR7.4DProject" --user-param "{\"action\":\"COMPILE_ONLY\"}"

#"$compiler" --headless --dataless --project "Project/CXR7.4DProject" --user-param "{\"action\":\"COMPILE_ONLY\"}"
"$compiler" --headless --dataless --project "Project/CXR7.4DProject" --user-param "{\"action\":\"COMPILED_STRUCTURE\"}"


echo "SCRIPT: Script done"
date
