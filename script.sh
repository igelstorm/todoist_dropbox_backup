#!/usr/bin/env bash

source ./secret.env

echo "Fetching backup URL from Todoist"
backup_url=$(curl https://todoist.com/api/v7/backups/get \
    -d token=$TODOIST_TOKEN \
    | jq --raw-output '.[0].url')
filename=$(echo $backup_url | sed 's/^.*\///')

echo ""
echo "Downloading backup file from Todoist"
curl $backup_url > $filename

echo ""
echo "Uploading backup file to Dropbox"
curl -X POST https://content.dropboxapi.com/2/files/upload \
    --header "Authorization:Bearer $DROPBOX_TOKEN" \
    --header "Dropbox-API-Arg: {\"path\": \"/$filename\",\"mode\": \"add\",\"autorename\": true,\"mute\": false}" \
    --header "Content-Type: application/octet-stream" \
    --data-binary @$filename

rm $filename
