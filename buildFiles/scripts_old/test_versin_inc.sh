#!/bin/bash

function inc_version() {

	version="$1"
	major=0
	minor=0
	build=0

	# break down the version number into it's components for 7.2.xxx
	# regex="([0-9]+).([0-9]+).([0-9]+)"
	regex="([0-9]+).([0-9]+)"

	if [[ $version =~ $regex ]]; then
	  major="${BASH_REMATCH[1]}"
	  minor="${BASH_REMATCH[2]}"
	  # build="${BASH_REMATCH[3]}"
	fi

	# check paramater to see which number to increment
	if [[ "$2" == "bug" ]]; then
  		minor=$(echo $minor + 1 | bc)
	elif [[ "$2" == "major" ]]; then
  		major=$(echo $major+1 | bc)
	else
		# minor=$(echo $minor + 1 | bc)
	fi
	
	# echo the new version number
	# echo "new version: ${major}.${minor}.${build}"
	# echo "new version: ${major}.${minor}"
	echo ${major}.${minor}

}

my_version='7.200'

new_version=$(inc_version $my_version 'bug')

echo "Nova verzija je: " $new_version
