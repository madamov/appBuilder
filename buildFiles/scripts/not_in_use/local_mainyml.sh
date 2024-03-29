#!/bin/bash

# script resembles main.yml in GitHub action runner to run test on local machine or VM

# define env variables to use in all scripts
export RUNNER_ACTOR="madamov"
export RUNNER="LOCAL"

# not used anymore: getting usernames from separate files, moved to one JSOn file now
# export WHO_TO_TRUST=$(<$HOME/Desktop/BUILDER/whototrust.txt)
# export BINARIES_USER=$(<$HOME/Desktop/BUILDER/builderuser.txt)
# export BINARIES_PASSWORD=$(<$HOME/Desktop/BUILDER/builderpass.txt)

export WHO_TO_TRUST=$(jq -r '.WHO_TO_TRUST' $HOME/Desktop/BUILDER/usernames.json)
export BINARIES_USER=$(jq -r '.BINARIES_USER' $HOME/Desktop/BUILDER/usernames.json)
export BINARIES_PASSWORD=$(jq -r '.BINARIES_PASSWORD' $HOME/Desktop/BUILDER/usernames.json)
export UPLOAD_USER=$(jq -r '.UPLOAD_USER' $HOME/Desktop/BUILDER/usernames.json)
export UPLOAD_PASSWORD=$(jq -r '.UPLOAD_PASSWORD' $HOME/Desktop/BUILDER/usernames.json)

# set current directory to one where repository is
cd $HOME/Desktop/BUILDER/WorkFiles/builderDemo/my4DApp

# we build only from main branch
git switch main

workingDirectory=$(pwd)

mkdir $HOME/Documents/artifacts

./buildFiles/scripts/build_all.sh
# ./buildFiles/scripts/build_all.sh NOVL NO4D


STATUSFILE=$HOME/Documents/artifacts/status.log

if [[ -f "$STATUSFILE" ]]; then
    msg="*Compilation or build failed!* at $(date)"
else
    ./buildFiles/scripts/postBuild.sh
    ./buildFiles/scripts/incbuildnumber.sh
    echo "🐚: POSTBUILD done at $(date)"
fi
