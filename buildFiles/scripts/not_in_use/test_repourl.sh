#!/bin/bash

workingDirectory=$(pwd)

repoURL=$(jq -r '.repoMacStandalone' $workingDirectory/buildFiles/parameters.json)

