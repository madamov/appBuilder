#!/bin/bash

# increases version string by 1 where version string is in a form 7.2.10

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
if [[ "$2" == "feature" ]]; then
  minor=$(echo $minor + 1 | bc)
elif [[ "$2" == "bug" ]]; then
  # build=$(echo $build + 1 | bc)
elif [[ "$2" == "major" ]]; then
  major=$(echo $major+1 | bc)
else
  echo "usage: ./version.sh version_number [major/feature/bug]"
  exit -1
fi

# echo the new version number
# echo "new version: ${major}.${minor}.${build}"
echo "new version: ${major}.${minor}"
