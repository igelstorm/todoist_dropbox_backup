#!/usr/bin/env bash

source ./secret.env

# backup_url=$(curl https://todoist.com/api/v7/backups/get \
#     -d token=$TODOIST_TOKEN \
#     | jq '.[0].url')

# echo $backup_url

curl -X POST https://content.dropboxapi.com/2/files/upload \
    --header "Authorization:Bearer $DROPBOX_TOKEN" \
    --header "Dropbox-API-Arg: {\"path\": \"/test.txt\",\"mode\": \"add\",\"autorename\": true,\"mute\": false}" \
    --header "Content-Type: application/octet-stream" \
    --data-binary @test.txt

