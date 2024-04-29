#!/bin/bash

# make release for compiled structure to public Github repo

workingDirectory=$(pwd)

echo "Releasing compiled structure"
echo "curr dir in release_structure is $workingDirectory"

destinationFolder=$1
build=$2
version=$3

echo "Destination folder path in release_structure.sh: $destinationFolder"

uploadURL=$(jq -r '.uploadCompiledStruct' $workingDirectory/buildFiles/parameters.json)
appName=$(jq -r '.appName' $workingDirectory/buildFiles/parameters.json)

cd $destinationFolder
mv Compiled\ Database comp_struct

myStructDest="$destinationFolder/comp_struct"

# make Settings folder for directory.json file
# mkdir $myStructDest/${appName}/Settings
# cp $workingDirectory/buildFiles/directory.json $myStructDest/${appName}/Settings/directory.json
# cp -R $workingDirectory/WebFolder $myStructDest/${appName}/WebFolder

# create zip archive
cd $myStructDest
zip -rqy $HOME/Documents/${appName}_struct.zip *


if [ -z "$uploadURL" ]; then
	echo "no upload of compiled structure"
else

	hdiutil create -format UDBZ -srcfolder "${myStructDest}" $HOME/Documents/${appName}_struct.dmg
	
	myStructURL=$uploadURL$version/$build
	echo "Uploading to folder: $myStructURL"
	
	/usr/local/opt/curl/bin/curl -k -s -u ${UPLOAD_USER}:${UPLOAD_PASSWORD} --ftp-create-dirs -T $HOME/Documents/${appName}_struct.zip ${myStructURL}/${appName}_struct.zip
	/usr/local/opt/curl/bin/curl -k -s -u ${UPLOAD_USER}:${UPLOAD_PASSWORD} --ftp-create-dirs -T $HOME/Documents/${appName}_struct.dmg ${myStructURL}/${appName}_struct.dmg

fi

cd $workingDirectory
