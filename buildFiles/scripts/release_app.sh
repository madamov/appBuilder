#!/bin/bash

# make release of standalone macOS app

workingDirectory=$(pwd)

echo "🐚🐚 : curr dir in release_app $workingDirectory"

destinationFolder=$1
build=$2
version=$3

echo "🐚🐚 : Destination folder path in release_app.sh: $destinationFolder"


repoURL=$(jq -r '.repo' $workingDirectory/buildFiles/parameters.json)
uploadURL=$(jq -r '.uploadMacStandalone' $workingDirectory/buildFiles/parameters.json)
appName=$(jq -r '.appName' $workingDirectory/buildFiles/parameters.json)
doNotarize=$(jq -r '.macOS.notarize' $workingDirectory/buildFiles/parameters.json)

echo "🐚🐚 : Making release of Mac standalone app ..."

# make Settings folder for directory.json file
# mkdir Settings
# cp $workingDirectory/buildFiles/directory.json Settings/directory.json

cd $destinationFolder
	
# rename destination folder, space in name creates problem
mv Final\ Application final_app

myAppDest="$destinationFolder/final_app"

# cp -R $workingDirectory/WebFolder $myAppDest/${appName}.app/Contents/Database/WebFolder

if [ -z "$uploadURL" ]; then
	echo "🐚🐚 : no upload of Mac standalone required"
else

	echo "Creating image file at $HOME/Documents/${appName}.dmg"

	hdiutil create -volname "${appName}" -ov -format UDBZ -srcfolder "${myAppDest}" $HOME/Documents/${appName}.dmg

	if [[ $doNotarize == *"True"* ]]; then

		echo "Notarizing image $HOME/Documents/${appName}.dmg starting at $(date)"
		
		xcrun notarytool submit $HOME/Documents/${appName}.dmg --keychain-profile "myApp_profile" --wait --output-format json > $HOME/Documents/artifacts/notarization.json

		echo "End notarizing image $HOME/Documents/${appName}.dmg at $(date)"

		cat $HOME/Documents/artifacts/notarization.json

		status=$(jq -r '.status' $HOME/Documents/artifacts/notarization.json)

		echo "Notarization status is: $status"	
		
		if [[ $status == *"Accepted"* ]]; then

			id=$(jq -r '.id' $HOME/Documents/artifacts/notarization.json)

			echo "Stapling image $HOME/Documents/${appName}.dmg notarizing id is $id"
	
			xcrun stapler staple $HOME/Documents/${appName}.dmg
	
		fi		
	fi

	myStructURL=$uploadURL$version/$build
	echo "Uploading to folder: $myStructURL"

	/usr/local/opt/curl/bin/curl -k -s -u ${UPLOAD_USER}:${UPLOAD_PASSWORD} --ftp-create-dirs -T $HOME/Documents/${appName}.dmg ${myStructURL}/${appName}.dmg

fi

ls -al $HOME/Documents > $HOME/Documents/artifacts/after_app_build_listing.txt

cd $workingDirectory
