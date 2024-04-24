#!/bin/bash

# make release of standalone macOS app

workingDirectory=$(pwd)

echo "🐚🐚 : curr dir in release_app $workingDirectory"

destinationFolder=$1
build=$2
version=$3

echo "🐚🐚 : Destination folder path in release_structure.sh: $destinationFolder"


# repoURL=$(jq -r '.repoMacStandalone' $workingDirectory/buildFiles/parameters.json)
repoURL=$(jq -r '.repo' $workingDirectory/buildFiles/parameters.json)
uploadURL=$(jq -r '.uploadMacStandalone' $workingDirectory/buildFiles/parameters.json)
appName=$(jq -r '.appName' $workingDirectory/buildFiles/parameters.json)

echo "🐚🐚 : Making release of Mac standalone app ..."

# cd $appName

# make Settings folder for directory.json file
# mkdir Settings
# cp $workingDirectory/buildFiles/directory.json Settings/directory.json

cd $destinationFolder
	
# cd Final\ Application
# rename destination folder, space in name creates problem for create-dmg.sh
mv Final\ Application final_app

myAppDest="$destinationFolder/final_app"
	
# cp -R $workingDirectory/Flags_Exported $myAppDest/${appName}.app/Contents/Database/Flags_Exported
cp -R $workingDirectory/WebFolder $myAppDest/${appName}.app/Contents/Database/WebFolder

version=$(jq -r '.version' $workingDirectory/buildFiles/parameters.json)
# buildnumber=$(jq -r '.build' $workingDirectory/buildFiles/parameters.json)
buildnumber=$REPO_BUILD_NUMBER
releasetag=v"$version"_build_"$buildnumber"

if [ -z "$uploadURL" ]; then
	echo "🐚🐚 : no upload of Mac standalone required"
else

#	$HOME/Documents/createdmg/create-dmg --volname "${appName}" --app-drop-link 600 185 $HOME/Documents/${appName}.dmg $destinationFolder/Final\ Application/*
#	$HOME/Documents/createdmg/create-dmg --volname "${appName}" --app-drop-link 600 185 $HOME/Documents/${appName}.dmg ${myAppDest}
#	$workingDirectory/buildFiles/scripts/create-dmg/create-dmg-patched.sh --volname "${appName}" --app-drop-link 600 185 $HOME/Documents/${appName}.dmg ${myAppDest}

	# create dmg using hdiutil directly without mounting the image, it takes long time and the image can't be detached
	hdiutil create -volname "${appName}" -srcfolder ${myAppDest} $HOME/Documents/${appName}_tmp.dmg
	
	# compress image
	hdiutil convert $HOME/Documents/${appName}_tmp.dmg -format UDBZ -o $HOME/Documents/${appName}.dmg
	
#	/usr/local/opt/curl/bin/curl -k -s -u ${UPLOAD_USER}:${UPLOAD_PASSWORD} -T $HOME/Documents/${appName}.dmg ${uploadURL}

	myStructURL=$uploadURL$version/$build
	echo "Uploading to folder: $myStructURL"

	/usr/local/opt/curl/bin/curl -k -s -u ${UPLOAD_USER}:${UPLOAD_PASSWORD} --ftp-create-dirs -T $HOME/Documents/${appName}.dmg ${myStructURL}/${appName}.dmg

fi

ls -al $HOME/Documents > $HOME/Documents/artifacts/after_app_build_listing.txt

if [ -z "$repoURL" ]; then
	echo "🐚🐚 : no repository for Mac standalone defined"
else
	
	if [[ "$repoURL" != "null" ]]; then
	
		# mkdir $HOME/Documents/app_repo
	
		# $WHO_TO_TRUST is secret in environment variable set in main.yml jobs section as first thing before everything
		# $RUNNER_ACTOR is also set in main.yml
	
		# git clone https://$RUNNER_ACTOR:$WHO_TO_TRUST@$repoURL $HOME/Documents/app_repo
	
		# rm -R $HOME/Documents/app_repo/*
	
		# echo "🐚🐚 : Copying files ..."
	
		# cp -R * $HOME/Documents/app_repo/
		# ls -alR $HOME/Documents/app_repo/ > $HOME/Documents/artifacts/build_app_listing.txt
	
		# echo "🐚🐚 : End copying to standalone release repository ..."
		
		cd $HOME/Documents/release_repo/
		
		# authentication is now in main.yml for all jobs via GH_TOKEN environment variable
		# echo $WHO_TO_TRUST | gh auth login --with-token
		
		# git add .
		# git commit -m "Releasing version $version build $buildnumber of Mac standalone app"
		# git push -q

		if [ -z "$release_created" ]; then
			echo "Creating release"
			gh release create "$releasetag" --notes "Release $version build $buildnumber"
		fi

		# echo "Uploading standalone dmg to release"
		# gh release upload "$releasetag" "$HOME/Documents/${appName}.dmg"

	else
	
		echo "🐚🐚 : Do nothing with app repo, jq returned null for repoMacStandalone"
		
	fi
fi


cd $workingDirectory
       