#!/bin/bash

echo "🐚 : Start of script: $(date), running in $RUNNER"

workingDirectory=$(pwd)
next_build=$(jq -r '.build' ./buildFiles/parameters.json)
thisBuildDestinationFolder=$HOME/Documents/$next_build
	
mkdir $thisBuildDestinationFolder

echo created destination folder: 
echo $thisBuildDestinationFolder

# get project name from a 4DProject filename
project4DFile=$(find ./Project -type f -name "*.4DProject")
projectName=$(basename $project4DFile ".4DProject")
         
         
# disable Gatekeeper and application translocating, may save us some processing cycles
# sudo spctl --master-disable
# echo "🐚 : macOS Gatekeeper disabled"

# we are using DMG Canvas command line tool now

# we were using https://github.com/create-dmg/create-dmg to build dmg for our application
#mkdir $HOME/Documents/createdmg
#git clone https://github.com/create-dmg/create-dmg.git $HOME/Documents/createdmg


# cat $workingDirectory/buildFiles/parameters.json

action=$(jq -r '.actionMac' $workingDirectory/buildFiles/parameters.json)

# ls -al $workingDirectory/Project/
rm $workingDirectory/Project/settings.4DSettings
# ls -al $workingDirectory/Project/
cp -fv $workingDirectory/buildFiles/Default_settings.4DSettings $workingDirectory/Project/Sources/settings.4DSettings
echo "settings file copied to repository"
# ls -al $workingDirectory/Project/Sources/

if [[ $action == *"BUILD_APP"* ]]; then
	if [[ $1 == "NOVL" ]]; then
		echo "🐚 : Skip downloading of 4D Volume Desktop"
	else
		url4dvl=$(jq -r '.macVL_URL' $workingDirectory/buildFiles/parameters.json)
		/bin/bash $workingDirectory/buildFiles/scripts/get4DVL.sh $url4dvl
	fi 
fi

if [[ $action == *"BUILD_SERVER"* ]]; then
	url4dvl=$(jq -r '.macServer_URL' $workingDirectory/buildFiles/parameters.json)
	/bin/bash $workingDirectory/buildFiles/scripts/get4DServer.sh $url4dvl
	if [[ $action == *"INCLUDE_WIN_CLIENT"* ]]; then
		url4dvl=$(jq -r '.winVL_URL' $workingDirectory/buildFiles/parameters.json)
		/bin/bash $workingDirectory/buildFiles/scripts/get4Win4DVL.sh $url4dvl
	fi
fi

url=$(jq -r '.maclicenses_URL' $workingDirectory/buildFiles/parameters.json)

# download developer licenses archive, extract it and move them in correct location for 4D to use them
/bin/bash $workingDirectory/buildFiles/scripts/licenses.sh $url

if [[ $2 == "NO4D" ]]; then
	echo "🐚 : Skip downloading of 4D standalone"
else
	# get and extract 4D standalone
	url4d=$(jq -r '.mac4D_URL' $workingDirectory/buildFiles/parameters.json)
	/bin/bash $workingDirectory/buildFiles/scripts/get4D.sh $url4d
fi

compiler="/Applications/4D.app/Contents/MacOS/4D"
projectFile=$workingDirectory/Project/$projectName.4DProject

# echo $projectFile

# run 4D and let 4D do the work
echo "🐚: Starting 4D at $(date)"

userParams=$(jq -r '.' $workingDirectory/buildFiles/parameters.json)
"$compiler" --headless --dataless --project "$projectFile" --user-param "$userParams"

echo "🐚: 4D done at $(date)"

ls -al $thisBuildDestinationFolder/artifacts
ls -al $thisBuildDestinationFolder/MyBuild


echo "🐚: Build script done at $(date)"
