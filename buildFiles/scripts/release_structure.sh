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
# buildnumber=$(jq -r '.build' $workingDirectory/buildFiles/parameters.json)
buildnumber=$REPO_BUILD_NUMBER
releasetag=v"$version"_build_"$buildnumber" 

echo "Repo for compiled structure is $repoURL, release tag is $releasetag"

# $WHO_TO_TRUST is secret in environment variable set in main.yml jobs section as first thing before everything
# $RUNNER_ACTOR is also set in main.yml


cd $destinationFolder
mv Compiled\ Database comp_struct

myStructDest="$destinationFolder/comp_struct"

# make Settings folder for directory.json file
# mkdir $myStructDest/CXR7/Settings
# cp $workingDirectory/buildFiles/directory.json $myStructDest/CXR7/Settings/directory.json
# cp -R $workingDirectory/Flags_Exported $myStructDest/CXR7/Flags_Exported
cp -R $workingDirectory/WebFolder $myStructDest/CXR7/WebFolder

# create zip archive
cd $myStructDest
zip -rqy $HOME/Documents/${appName}_struct.zip *


if [ -z "$uploadURL" ]; then
	echo "no upload of compiled structure"
else

#	$HOME/Documents/createdmg/create-dmg --volname "${appName}_Structure" $HOME/Documents/${appName}_struct.dmg $destinationFolder/Compiled\ Database/*

	# create dmg using hdiutil directly without mounting the image, it takes long time and the image can't be detached
#	hdiutil create -volname "${appName}_Structure" -srcfolder ${myStructDest} $HOME/Documents/${appName}_structtmp.dmg
	
	# compress image
#	hdiutil convert $HOME/Documents/${appName}_structtmp.dmg -format UDBZ -o $HOME/Documents/${appName}_struct.dmg
	
	myStructURL=$uploadURL$version/$build
	echo "Uploading to folder: $myStructURL"
	
#	/usr/local/opt/curl/bin/curl -k -s -u ${UPLOAD_USER}:${UPLOAD_PASSWORD} -T $HOME/Documents/${appName}_struct.dmg ${uploadURL}
#	/usr/local/opt/curl/bin/curl -k -s -u ${UPLOAD_USER}:${UPLOAD_PASSWORD} -T $HOME/Documents/${appName}_struct.zip ${uploadURL}
#	/usr/local/opt/curl/bin/curl -k -s -u ${UPLOAD_USER}:${UPLOAD_PASSWORD} --ftp-create-dirs -T $HOME/Documents/${appName}_struct.dmg ${myStructURL}/${appName}_struct.dmg
#	/usr/local/opt/curl/bin/curl -k -s -u ${UPLOAD_USER}:${UPLOAD_PASSWORD} --ftp-create-dirs -T $HOME/Documents/${appName}_struct.zip ${myStructURL}/${appName}_struct.zip
	/usr/local/opt/curl/bin/curl -k -s -u ${UPLOAD_USER}:${UPLOAD_PASSWORD} --ftp-create-dirs -T $HOME/Documents/${appName}_struct.zip ${myStructURL}/${appName}_struct.zip

fi

if [ -z "$repoURL" ]; then
	echo "no repository defined"
	echo "release_tag=none" >> "$GITHUB_OUTPUT"
else
	mkdir $HOME/Documents/release_repo/
	git clone https://$RUNNER_ACTOR:$WHO_TO_TRUST@$repoURL $HOME/Documents/release_repo
	echo "🐚🐚 : Deleting old files from repo..."
	rm -R $HOME/Documents/release_repo/*
	rm -R $HOME/Documents/release_repo/.gitignore
	# echo "🐚🐚 : Copying files ..."
	# cp -R $myStructDest/CXR7/* $HOME/Documents/release_repo/
	# ls -alR $HOME/Documents/release_repo/ > $HOME/Documents/artifacts/build_listing.txt
	# echo "🐚🐚 : End copying to compiled structure release repository ..."
	cd $HOME/Documents/release_repo/
	
	# authentication is now in main.yml for all jobs via GH_TOKEN environment variable
	# echo $WHO_TO_TRUST | gh auth login --with-token

	echo "Version ${version} build ${oldbuild}" > vm_v${version}_b${buildnumber}.txt
	git add .
	git commit -m "Releasing version $version build $buildnumber of compiled structure"
	git push
	gh release create "$releasetag" --notes "Release $version build $buildnumber"
	gh release upload "$releasetag" "$HOME/Documents/${appName}_struct.zip"
	# let other runners know we've created release
	echo "release_tag=$releasetag" >> "$GITHUB_OUTPUT"
	# let other scripts know we've created Release
	release_created=true
	
fi

cd $workingDirectory
