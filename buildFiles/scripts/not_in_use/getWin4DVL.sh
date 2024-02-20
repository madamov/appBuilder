#!/bin/bash

# download 4D Volume Desktop for Windows, leave it in Documents folder, we will refer to it in buildApp.4DSettings XML file

workingDirectory=$(pwd)

echo "🐚:🐚: Downloading 4D Volume Desktop for Windows ..."
curl -s -o $HOME/Documents/4D_VL_Windows.zip $1
echo "🐚:🐚: 4D Volume Desktop Windows downloaded, unzipping archive ..."
unzip -q $HOME/Documents/4D_VL_Windows -d $HOME/Documents/
echo "🐚:🐚: 4D Volume Desktop Windows unzipped"
