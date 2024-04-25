#!/bin/bash

# increases build number and pushes back modified parameters.json file

workingDirectory=$(pwd)

version=$(jq -r '.version' $workingDirectory/buildFiles/parameters.json)
oldbuild=$(jq -r '.build' $workingDirectory/buildFiles/parameters.json)

build=$((oldbuild+1))

jq --argjson mybuildno "$build" '.build = $mybuildno' $workingDirectory/buildFiles/parameters.json > $HOME/tmp.json

mv $HOME/tmp.json $workingDirectory/buildFiles/parameters.json

# do not push if run locally on computer, it will start Github action

# create and upload version.json to SFTP server for automatic updates

# where to uplaod version.json?
versionUploadURL=$(jq -r '.versionFileUploadURL' $workingDirectory/buildFiles/parameters.json)

# URL to remote version file
versionURL=$(jq -r '.versionURL' $workingDirectory/buildFiles/parameters.json)

# jq -n --arg jq_version "$version" --arg jq_build "$oldbuild" --arg jq_url "$url" --arg jq_updateurl "$versionURL" '{"version":$jq_version, "buildNumber":$jq_build, "URL":$jq_url, "UpdateURL":$jq_updateurl}' > $HOME/version.json

jq -n --arg jq_version "$version" --arg jq_build "$oldbuild" --arg jq_url "$url" --arg jq_updateurl "$versionURL" '{"version":$jq_version, "buildNumber":$jq_build, "URL":$jq_updateurl, "UpdateURL":$jq_url}' > $HOME/version.json

# builtin Ubuntu curl doesn't support SFTP, we installed Hombrew version when runner started

cat $HOME/version.json
echo $versionUploadURL

# /home/linuxbrew/.linuxbrew/bin/curl -k -s -u ${UPLOAD_USER}:${UPLOAD_PASSWORD} --ftp-create-dirs -T $HOME/version.json ${versionUploadURL}/version.json

/home/linuxbrew/.linuxbrew/bin/curl -k -u ${UPLOAD_USER}:${UPLOAD_PASSWORD} --ftp-create-dirs -T $HOME/version.json ${versionUploadURL}/version.json



if [[ $RUNNER == *"GIT"* ]]; then
	rm $workingDirectory/vm_v*
	echo "Version ${version} build ${oldbuild}" > $workingDirectory/vm_v${version}_b${oldbuild}.txt
	jq -n --arg myversion "$version" --arg mybuild "$oldbuild" '{"buildNumber":$mybuild, "version":$myversion}' > $workingDirectory/Resources/version.json
	git config --global user.name 'CXR Github action bot'
	git config --global user.email 'milan@clearviewsys.com'
	git add .
	git add $workingDirectory/vm_v${version}_b${oldbuild}.txt
	git commit -m "Uploaded parameters.json with new build number ${build}"
	git push
	git fetch --unshallow
    git checkout develop
    git pull
    git merge --no-ff main -m "Auto-merge main back to develop"
    git push
	echo "New JSON parameters file pushed back with build number ${build}"
fi

