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
	
# rename destination folder, space in name creates problem for create-dmg.sh
mv Client\ server\ executable final_app

myAppDest="$destinationFolder/final_app/${appName}\ Server"
	
# cp -R $workingDirectory/WebFolder $myAppDest/${appName}.app/Contents/Database/WebFolder


if [ -z "$uploadURL" ]; then
	echo "🐚🐚 : no upload of Mac standalone required"
else

	echo "Creating server image file at $HOME/Documents/${appName}_server.dmg"
	hdiutil create -volname "${appName}_server" -format UDBZ -srcfolder "${myAppDest}" $HOME/Documents/${appName}_server.dmg

	myStructURL=$uploadURL$version/$build
	echo "Uploading to folder: $myStructURL"

	/usr/local/opt/curl/bin/curl -k -s -u ${UPLOAD_USER}:${UPLOAD_PASSWORD} --ftp-create-dirs -T $HOME/Documents/${appName}_server.dmg ${myStructURL}/${appName}_server.dmg

fi

ls -al $HOME/Documents > $HOME/Documents/artifacts/after_app_build_listing.txt

cd $workingDirectory
       