#!/bin/bash

workingDirectory=$(pwd)

destination=$(jq -r '.buildDestinationFolder' $workingDirectory/buildFiles/parameters.json)
destFolder=$(dirname "$workingDirectory")/${destination}

echo $destFolder

doNotarize=$(jq -r '.macOS.notarize' $workingDirectory/buildFiles/parameters.json)
echo $doNotarize

appName=$(jq -r '.appName' $workingDirectory/buildFiles/parameters.json)
echo $appName

# myAppDest="$destFolder/Final\ Application/" # this is not working in ls and  hdiutil
myAppDest=$destFolder/Final\ Application/

echo "Creating image file at $destFolder/${appName}.dmg"
hdiutil create -ov -volname "${appName}" -format UDBZ -srcfolder "${myAppDest}" $destFolder/${appName}.dmg

# xcrun notarytool store-credentials myApp_profile --apple-id "$APPLE_ID" --team-id "$TEAM_ID" --password "$APP_SPECIFIC_PASSWORD"

echo Notarization

xcrun notarytool submit $destFolder/${appName}.dmg --keychain-profile "myApp_profile" --wait --output-format json > $destFolder/notarytool.json

status=$(jq -r '.status' $destFolder/notarytool.json)

echo $status

if [[ $status == *"Accepted"* ]]; then

	id=$(jq -r '.id' $destFolder/notarytool.json)

	echo "Stapling $id"
	
	xcrun stapler staple $destFolder/${appName}.dmg
	
fi
