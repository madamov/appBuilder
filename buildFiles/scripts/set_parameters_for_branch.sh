#!/bin/bash

# use correct parameters.json file based on branch


         if [ "$(basename $GITHUB_REF)" == "release" ]; then
            # Use release server for uploads
            echo Using release branch server parameters
            mv ./buildFiles/parameters_releases.json ./buildFiles/parameters.json
         fi
         if [ "$(basename $GITHUB_REF)" == "develop" ]; then
            # Use test server for uploads
            echo "Using test server parameters for branch develop"
            mv ./buildFiles/parameters_testserver.json ./buildFiles/parameters.json
         fi

