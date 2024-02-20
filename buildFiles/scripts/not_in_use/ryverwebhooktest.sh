#!/bin/bash

msg="Testing ryver webhooks $(date)"

curl -X "POST" "https://clearviewsys.ryver.com/application/webhook/jeF3RLWy7EokK5G" -H "Content-Type: text/plain; charset=utf-8" -d "$msg"