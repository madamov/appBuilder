#!/bin/bash

uploadURL=$(jq -r '.uploadCompiledStruct' $workingDirectory/buildFiles/parameters.json)

echo "User je $UPLOAD_USER"
echo "URL je $uploadURL"

ls -al /usr/local/opt/

echo "Test text" > $HOME/Documents/test.txt
 
echo "Using Homebrew curl"
 
/usr/local/opt/curl/bin/curl -k -u ${UPLOAD_USER}:${UPLOAD_PASSWORD} --ftp-create-dirs -T $HOME/Documents/test.txt ${myStructURL}/test_001.txt

echo "Using curl"

which curl

curl -k -u ${UPLOAD_USER}:${UPLOAD_PASSWORD} --ftp-create-dirs -T $HOME/Documents/test.txt ${myStructURL}/test_001.txt
