#!/bin/bash

# make release of standalone macOS app

workingDirectory=$(pwd)

echo "🐚🐚 : curr dir in release_app $workingDirectory"

destinationFolder=$1
build=$2
version=$3

echo "🐚🐚 : Destination folder path in release_structure.sh: $destinationFolder"


repoURL=$(jq -r '.repo' $workingDirectory/buildFiles/parameters.json)
uploadURL=$(jq -r '.uploadMacStandalone' $workingDirectory/buildFiles/parameters.json)
appName=$(jq -r '.appName' $workingDirectory/buildFiles/parameters.json)

echo "🐚🐚 : Making release of Mac standalone app ..."

# make Settings folder for directory.json file
# mkdir Settings
# cp $workingDirectory/buildFiles/directory.json Settings/directory.json

cd $destinationFolder
	
# rename destination folder, space in name creates problem for create-dmg.sh
mv Final\ Application final_app

myAppDest="$destinationFolder/final_app"
	
# cp -R $workingDirectory/WebFolder $myAppDest/${appName}.app/Contents/Database/WebFolder

# version=$(jq -r '.version' $workingDirectory/buildFiles/parameters.json)
# buildnumber=$(jq -r '.build' $workingDirectory/buildFiles/parameters.json)

if [ -z "$uploadURL" ]; then
	echo "🐚🐚 : no upload of Mac standalone required"
else

	# hdiutil create -volname "${appName}" -format UDBZ -plist -srcfolder "${myAppDest}" $HOME/Documents/${appName}.dmg
	hdiutil create -volname "${appName}" -format UDBZ -srcfolder "${myAppDest}" $HOME/Documents/${appName}.dmg

	myStructURL=$uploadURL$version/$build
	echo "Uploading to folder: $myStructURL"

	/usr/local/opt/curl/bin/curl -k -s -u ${UPLOAD_USER}:${UPLOAD_PASSWORD} --ftp-create-dirs -T $HOME/Documents/${appName}.dmg ${myStructURL}/${appName}.dmg

fi

ls -al $HOME/Documents > $HOME/Documents/artifacts/after_app_build_listing.txt

cd $workingDirectory
       