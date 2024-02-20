#!/bin/bash

# create variables
CERTIFICATE_PATH=/Volumes/Radni/madamov/Documents/4D/Projects/signing/for4D.p12
KEYCHAIN_PATH=/Volumes/Radni/madamov/Documents/4D/Projects/signing/app-signing.keychain-db
KEYCHAIN_PASSWORD=SezameOtvoriSe

# import certificate from secrets
base64 --decode -o $CERTIFICATE_PATH -i /Volumes/Radni/madamov/Documents/4D/Projects/signing/for4D.p12.base64


# create temporary keychain
security create-keychain -p "$KEYCHAIN_PASSWORD" $KEYCHAIN_PATH
security set-keychain-settings -lut 21600 $KEYCHAIN_PATH
security unlock-keychain -p "$KEYCHAIN_PASSWORD" $KEYCHAIN_PATH

# import certificate to keychain
security import $CERTIFICATE_PATH -A -k $KEYCHAIN_PATH
security list-keychain -d user -s $KEYCHAIN_PATH

workingDirectory=/Volumes/Radni/madamov/Documents/4D/Projects/Current/Clearviewsys/CXR/CXR7/CXR_github/CXR-4D
          
compiler="/Applications/4D\ v19\ R8/4D\ Rosetta.app/Contents/MacOS/4D"
projectFile=$workingDirectory/Project/CXR7.4DProject

/Applications/4D\ v19\ R8/4D\ Rosetta.app/Contents/MacOS/4D --headless --dataless --project "$projectFile" --user-param "{\"testSigning\":\"True\"'}"
