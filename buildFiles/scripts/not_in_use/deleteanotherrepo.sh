#!/bin/bash

build=$1

rm -R $HOME/Documents/another_repo/*
git add .
git commit -m "removed old build ${build}"
git push origin main
