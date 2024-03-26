#!/bin/bash

# sets UPLOAD_USER and UPLAOD_PASSWORD credentials based on branch we are in

         if [ "$(basename $GITHUB_REF)" == "MA/github_actions_builder" ]; then
            # Use test server for uploads
            echo Using test server parameters for branch $(basename $GITHUB_REF)
            mv ./buildFiles/parameters_testserver.json ./buildFiles/parameters.json
            export UPLOAD_USER=${{secrets.UPLOAD_TEST_USER}}
            export UPLOAD_PASSWORD=${{secrets.UPLOAD_TEST_PASSWORD}}            
         fi
         if [ "$(basename $GITHUB_REF)" == "release" ]; then
            # Use release server for uploads
            echo Using release branch server parameters
            mv ./buildFiles/parameters_releases.json ./buildFiles/parameters.json
            export UPLOAD_USER=${{secrets.UPLOAD_USER}}
            export UPLOAD_PASSWORD=${{secrets.UPLOAD_PASSWORD}}
         fi
         if [ "$(basename $GITHUB_REF)" == "develop" ]; then
            # Use test server for uploads
            # echo Using test server parameters for branch develop
            # mv ./buildFiles/parameters_testserver.json ./buildFiles/parameters.json
            # export UPLOAD_USER=${{secrets.UPLOAD_TEST_USER}}
            # export UPLOAD_PASSWORD=${{secrets.UPLOAD_TEST_PASSWORD}}
            
            # USE CXR NIGHTLY BUILD SERVER FOR TESTING, MAIN BRANCH WILL DO THAT ALSO
            echo nightly builds folder choosen
            mv ./buildFiles/parameters_nightly.json ./buildFiles/parameters.json
            export UPLOAD_USER=${{secrets.UPLOAD_USER}}
            export UPLOAD_PASSWORD=${{secrets.UPLOAD_PASSWORD}}
         fi
         if [ "$(basename $GITHUB_REF)" == "main" ]; then
            # Use default paramaters.json
            export UPLOAD_USER=${{secrets.UPLOAD_USER}}
            export UPLOAD_PASSWORD=${{secrets.UPLOAD_PASSWORD}}
         fi 
         