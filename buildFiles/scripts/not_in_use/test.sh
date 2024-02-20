#!/bin/bash

echo "SCRIPT: Start of build: $(date)"

workingDirectory=$(pwd)

# url=$(jq -r '.maclicenses_URL' $workingDirectory/buildFiles/parameters.json)

akcija=$(jq -r '.action' $workingDirectory/buildFiles/parameters.json)

echo $akcija parametsar je $1


if [[ $akcija == *"BUILD_APP"* ]]; then
	if [[ $1 == "NOVL" ]]; then
		echo "🐚 : Not downloading Volume desktop"
	else
		echo "🐚 : Downloading Volume desktop"
	fi 
fi

