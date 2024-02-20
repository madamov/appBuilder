#!/bin/bash

mkdir $HOME/Documents/repo
cd $HOME/Documents/repo

git clone https://github.com/clearviewsys/CXR-4D.git

git switch githubactions

cd CXR-4D

./scripts/compile.sh
