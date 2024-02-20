#!/bin/bash

echo "Start of build: "
date

workingDirectory=$(pwd)

# disable Gatekeeper and application translocating, may save us some processing cycles
sudo spctl --master-disable
echo "macOS Gatekeeper disabled"

# download developer licenses archive
curl -s -o $HOME/Documents/dev_v19_mac.zip https://www.adamov.co.rs/dev_v19_mac.zip
echo "Licenses downloaded"

if [ -d "$HOME/Documents/Licenses" ]; then
	echo "Licenses in Documents exists"
else
	mkdir $HOME/Documents/Licenses
	echo "Created Licenses folder in Documents folder"
fi

# extract licenses from archive
unzip $HOME/Documents/dev_v19_mac.zip -d $HOME/Documents/Licenses/

if [ -d "$HOME/Library/Application support/4D" ]; then
	echo "4D folder exists"
else 
	mkdir "$HOME/Library/Application support/4D"
fi

if [ -d "$HOME/Library/Application support/4D/Licenses" ]; then
	echo "Licenses folder exists"
else 
	mkdir "$HOME/Library/Application Support/4D/Licenses"
fi

# copy licenses so 4D is licensed as Developer Professional
# leave originals in Documents folder, we will refer to them in buildApp.4DSettings XML file
cp $HOME/Documents/Licenses/* $HOME/Library/Application\ Support/4D/Licenses/

echo "Licenses copied to " $HOME/Library/Application\ Support/4D/Licenses/

echo "Downloading 4D ..."
# download 4D and move it to /Applications folder
curl -s -o $HOME/Documents/4D_19_1.zip https://www.adamov.co.rs/4D_19_1.zip
echo "4D downloaded, unzipping archive ..."
unzip -q $HOME/Documents/4D_19_1.zip -d $HOME/Documents/
echo "4D unzipped"
mv $HOME/Documents/4D.app /Applications/4D.app
echo "4D moved to Applications folder"

ls -al /Applications

# download 4D VolumeDesktop, leave it in Documents folder, we will refer to it in buildApp.4DSettings XML file
echo "Downloading 4D Volume Desktop ..."
curl -s -o $HOME/Documents/4D_Volume_Desktop_19_1.zip https://www.adamov.co.rs/4D_Volume_Desktop_19_1.zip
echo "4D Volume Desktop downloaded, unzipping archive ..."
unzip -q $HOME/Documents/4D_Volume_Desktop_19_1.zip -d $HOME/Documents/
echo "4D Volume Desktop unzipped"

compilerOptions="--dataless --headless"
compiler="/Applications/4D.app/Contents/MacOS/4D"
projectFile=$workingDirectory/Project/CXR7.4DProject

# --user-param "{\"action\":\"COMPILE\", \"workingDirectory\":\"$workingDirectory\" ,\"options\":$options}"
# --user-param "{\"action\":\"BUILD\", \"templatePath\":\"$workingDirectory/buildApp_template.4DSettings\" ,\"options\":$options}"

# run 4D and let 4D do the work
echo "Starting 4D ..."
# "$compiler" $compilerOptions -p "$projectFile" --user-param "{\"action\":\"COMPILE\", \"workingDirectory\":\"$workingDirectory\" ,\"options\":$options}"
# "$compiler" --headless --dataless --project "$projectFile"  --user-param "{\"action\":\"BUILD\", \"buildApp\":\"true\", \"templatePath\":\"$workingDirectory/buildApp_template.4DSettings\"}"

# /Applications/4D.app/Contents/MacOS/4D --headless --dataless --project "Project/CXR7.4DProject" --user-param "{\"action\":\"BUILD\", \"buildApp\":\"true\", \"templatePath\":\"$workingDirectory/buildApp_template.4DSettings\"}"
/Applications/4D.app/Contents/MacOS/4D --headless --dataless --project "Project/CXR7.4DProject"

# zip and upload built files to destination
echo "Archiving resulting application ..."
cd $HOME/Documents/
mkdir MyBuild
cd MyBuild

# zip -rqy $HOME/Documents/cxr.zip *
7z a $HOME/Documents/cxr_mac.7z -r *

echo "Uploading archive ..."
# curl -s -k -u tiranb:elfin-fed-aunt -T $HOME/Documents/new_buildApp.4DSettings ftp://clearviewsys.4d.rs/gitactionstest/
curl -s -k -u tiranb:elfin-fed-aunt -T $HOME/Documents/cxr_mac.7z ftp://clearviewsys.4d.rs/gitactionstest/

echo "Script done"
date
