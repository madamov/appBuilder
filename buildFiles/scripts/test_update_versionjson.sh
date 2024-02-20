workingDirectory=$(pwd)

version=$(jq -r '.version' $workingDirectory/buildFiles/parameters.json)
oldbuild=$(jq -r '.build' $workingDirectory/buildFiles/parameters.json)
versionUploadURL=$(jq -r '.versionFileUploadURL' $workingDirectory/buildFiles/parameters.json)
versionURL=$(jq -r '.versionURL' $workingDirectory/buildFiles/parameters.json)

url="http://cvssftp.clearviewsys.com/cxr/cxr7_updates/version_test.json"

jq -n --arg jq_version "$version" --arg jq_build "$oldbuild" --arg jq_url "$url" --arg jq_updateurl "$versionURL" '{"version":$jq_version, "buildNumber":$jq_build, "URL":$jq_url, "UpdateURL":$jq_updateurl}' > $HOME/version.json

if [[ $RUNNER == *"GIT"* ]]; then

	/usr/local/opt/curl/bin/curl -k -s -u ${UPLOAD_USER}:${UPLOAD_PASSWORD} --ftp-create-dirs -T $HOME/version.json ${versionUploadURL}/version_test.json

else

	secrets=$workingDirectory/../secrets.json

	UPLOAD_USER=$(jq -r '.UPLOAD_USER' $secrets)
	UPLOAD_PASSWORD=$(jq -r '.UPLOAD_PASSWORD' $secrets)

	 /opt/homebrew/opt/curl/bin/curl -k -u ${UPLOAD_USER}:${UPLOAD_PASSWORD} --ftp-create-dirs -T $HOME/version.json ${versionUploadURL}/version_test.json
	
fi

# rm $HOME/version.json
