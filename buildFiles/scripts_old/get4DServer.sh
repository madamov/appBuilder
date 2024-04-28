#!/bin/bash


	echo "🐚:🐚: Downloading 4D Server..."

	curl -s -o $HOME/Downloads/4D_Server.zip $1
	echo "🐚:🐚: 4D Server $1 downloaded, unzipping archive ..."
	unzip -q $HOME/Downloads/4D_Server.zip -d $HOME/Documents/
	echo "🐚🐚:: 4D Server unzipped"

