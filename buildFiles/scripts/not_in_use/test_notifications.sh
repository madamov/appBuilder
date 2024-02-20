#!/bin/bash

         STATUSFILE=/Volumes/Radni/madamov/Documents/desktop.ini
         if [[ -f "$STATUSFILE" ]]; then
           echo "compilation failed"
           datum=$date
           echo "$datum"
           curl -X POST -H 'Content-type: application/json' --data '{"text":"Compilation or build failed on "'"$datum"'"}' https://hooks.slack.com/services/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
         else
           echo "🐚: POSTBUILD done at $(date)"
         fi