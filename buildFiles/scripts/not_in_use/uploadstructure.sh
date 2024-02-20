#!/bin/bash

# zip and upload compiled structure

workingDirectory=$(pwd)

destinationFolder=$1
build=$2
uploadTo=$3

echo "🐚 🐚 : Archiving resulting compiled structure ..."
cd $destinationFolder
cd Compiled\ Database


# zip -rqy $HOME/Documents/cxr.zip *
7z a $HOME/Documents/cxr_compstruct_${build}.7z -r *

echo "🐚 🐚 : Uploading archive ..."
# curl -s -k -u tiranb:elfin-fed-aunt -T $HOME/Documents/new_buildApp.4DSettings ftp://clearviewsys.4d.rs/gitactionstest/
curl -s -k -u tiranb:elfin-fed-aunt -T $HOME/Documents/cxr_compstruct_${build}.7z $uploadTo
