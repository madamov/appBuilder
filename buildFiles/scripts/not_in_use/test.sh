#!/bin/bash

workingDirectory=$(pwd)

# url=$(jq -r '.maclicenses_URL' $workingDirectory/buildFiles/parameters.json)

akcija=$(jq -r '.action' $workingDirectory/buildFiles/parameters.json)

echo $akcija parametar je $1


if [[ $akcija == *"BUILD_APP"* ]]; then
	if [[ $1 == "NOVL" ]]; then
		echo "🐚 : Not downloading Volume desktop"
	else
		echo "🐚 : Downloading Volume desktop"
	fi 
fi

echo ACESSING DIRECTLY
echo $MIKITEST
echo $TESTME
echo
echo Using env var syntax
echo "start of echo :"
echo "${{ env.MIKITEST }}"
echo "${{ env.TESTME }}"
echo "end of echo"
set
