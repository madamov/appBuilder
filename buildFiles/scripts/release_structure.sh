#!/bin/bash

# make release for compiled structure to public Github repo

workingDirectory=$(pwd)

echo "Releasing compiled structure"
echo "curr dir in release_structure is $workingDirectory"

destinationFolder=$1
build=$2
version=$3

echo "Destination folder path in release_structure.sh: $destinationFolder"


# repoURL=$(jq -r '.repoCompiledStruct' $workingDirectory/buildFiles/parameters.json)
repoURL=$(jq -r '.repo' $workingDirectory/buildFiles/parameters.json)
uploadURL=$(jq -r '.uploadCompiledStruct' $workingDirectory/buildFiles/parameters.json)
appName=$(jq -r '.appName' $workingDirectory/buildFiles/parameters.json)
version=$(jq -r '.version' $workingDirectory/buildFiles/parameters.json)

buildnumber=$REPO_BUILD_NUMBER
releasetag=v"$version"_build_"$buildnumber" 

echo "Repo for compiled structure is $repoURL, release tag is $releasetag"

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

	#   hdiutil create -format UDBZ -plist -srcfolder "${myStructDest}" $HOME/Documents/${appName}_struct.dmg
	
	myStructURL=$uploadURL$version/$build
	echo "Uploading to folder: $myStructURL"
	
	/usr/local/opt/curl/bin/curl -k -s -u ${UPLOAD_USER}:${UPLOAD_PASSWORD} --ftp-create-dirs -T $HOME/Documents/${appName}_struct.zip ${myStructURL}/${appName}_struct.zip

fi

cd $workingDirectory
