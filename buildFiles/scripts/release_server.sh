#!/bin/bash

# make release of macOS Server

workingDirectory=$(pwd)


destinationFolder=$1
build=$2
version=$3


uploadURL=$(jq -r '.uploadMacServer' $workingDirectory/buildFiles/parameters.json)
appName=$(jq -r '.appName' $workingDirectory/buildFiles/parameters.json)

echo "🐚🐚 : Making release of Mac Server ..."

cd $destinationFolder

# make Settings folder for directory.json file
# mkdir Settings
# cp $workingDirectory/buildFiles/directory.json Settings/directory.json
# cp -R $workingDirectory/WebFolder $myAppDest/${appName}.app/Contents/Database/WebFolder

# Server and client applications are both in Client Server executable folder
# we want to make separate dmg files for client and server
# move Server.app to separate folder

mkdir $destinationFolder/Server
mv $destinationFolder/Client\ Server\ executable/${appName}\ Server.app $destinationFolder/Server/${appName}\ Server.app
myAppDest="$destinationFolder/Server"



if [ -z "$uploadURL" ]; then
	echo "🐚🐚 : no upload of Mac server required"
else

	echo "Creating server image file at $HOME/Documents/${appName}_server.dmg"
	hdiutil create -volname "${appName}_server" -format UDBZ -srcfolder "${myAppDest}" $HOME/Documents/${appName}_server.dmg

	doNotarize=$(jq -r '.macOS.notarize' $workingDirectory/buildFiles/parameters.json)

	if [[ $doNotarize == *"True"* ]]; then

		echo "Notarizing image $HOME/Documents/${appName}_server.dmg starting at $(date)"
		
		xcrun notarytool submit $HOME/Documents/${appName}_server.dmg --keychain-profile "myApp_profile" --wait --output-format json > $HOME/Documents/artifacts/notarization_server.json

		echo "End notarizing image $HOME/Documents/${appName}_server.dmg at $(date)"

		cat $HOME/Documents/artifacts/notarization_server.json

		status=$(jq -r '.status' $HOME/Documents/artifacts/notarization_server.json)

		echo "Notarization status is: $status"	
		
		if [[ $status == *"Accepted"* ]]; then

			id=$(jq -r '.id' $HOME/Documents/artifacts/notarization_server.json)

			echo "Stapling image $HOME/Documents/${appName}_server.dmg notarizing id is $id"
	
			xcrun stapler staple $HOME/Documents/${appName}_server.dmg
	
		fi		
	fi

	myStructURL=$uploadURL$version/$build
	echo "Uploading to folder: $myStructURL"

	/usr/local/opt/curl/bin/curl -k -s -u ${UPLOAD_USER}:${UPLOAD_PASSWORD} --ftp-create-dirs -T $HOME/Documents/${appName}_server.dmg ${myStructURL}/${appName}_server.dmg

fi

ls -al $HOME/Documents > $HOME/Documents/artifacts/after_app_build_listing.txt

cd $workingDirectory
