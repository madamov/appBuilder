#!/bin/bash

# make release of macOS Client

workingDirectory=$(pwd)


destinationFolder=$1
build=$2
version=$3


uploadURL=$(jq -r '.uploadMacServer' $workingDirectory/buildFiles/parameters.json)
appName=$(jq -r '.appName' $workingDirectory/buildFiles/parameters.json)

echo "🐚🐚 : Making release of Mac Client ..."

cd $destinationFolder

# make Settings folder for directory.json file
# mkdir Settings
# cp $workingDirectory/buildFiles/directory.json Settings/directory.json
	
# Server and client applications are both in Client Server executable folder
# we want to make separate dmg files for client and server
# move Client.app to separate folder

mkdir $destinationFolder/Client
mv $destinationFolder/Client\ Server\ executable/${appName}\ Client.app $destinationFolder/Client/${appName}\ Client.app
myAppDest="$destinationFolder/Client"
	
if [ -z "$uploadURL" ]; then
	echo "🐚🐚 : no upload of Mac client requested"
else
	
	echo "Creating client image file at $HOME/Documents/${appName}_client.dmg"
	hdiutil create -volname "${appName}_client" -format UDBZ -srcfolder "${myAppDest}" $HOME/Documents/${appName}_client.dmg

	myStructURL=$uploadURL$version/$build
	echo "Uploading to folder: $myStructURL"

	/usr/local/opt/curl/bin/curl -k -s -u ${UPLOAD_USER}:${UPLOAD_PASSWORD} --ftp-create-dirs -T $HOME/Documents/${appName}_client.dmg ${myStructURL}/${appName}_client.dmg

fi

cd $workingDirectory
