#!/bin/bash

workingDirectory=$(pwd)

uploadURL=$(jq -r '.uploadCompiledStruct' $workingDirectory/buildFiles/parameters.json)

echo "User je $UPLOAD_USER"
echo "URL je $uploadURL"

ls -al /usr/local/opt/ > $HOME/Documents/test.txt

echo "Test text" >> $HOME/Documents/test.txt

curl -k -u builder4d:idolize-roof-scud-rigour -T $HOME/Documents/test.txt sftp://updates.4d.rs/home/builder4d/updates.4d.rs/appBuilder/log4D.txt


# echo "Using Homebrew curl"
 
# /usr/local/opt/curl/bin/curl -k -u ${UPLOAD_USER}:${UPLOAD_PASSWORD} --ftp-create-dirs -T $HOME/Documents/test.txt ${uploadURL}/test_001.txt

echo "Using curl, path je: "

which curl

curl -k -u ${UPLOAD_USER}:${UPLOAD_PASSWORD} --ftp-create-dirs -T $HOME/Documents/test.txt ${uploadURL}/test_001.txt

