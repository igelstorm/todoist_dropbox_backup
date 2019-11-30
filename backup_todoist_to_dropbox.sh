#!/usr/bin/env bash

source ./secret.env

echo "Fetching backup details from Todoist"
most_recent=$(curl https://todoist.com/api/v8/backups/get \
    -d token=$TODOIST_TOKEN \
    | jq --raw-output '.[0]')

backup_url=$(echo $most_recent | jq --raw-output '.url')
filename=$(echo $backup_url | sed 's/^.*\///')

timestamp=$(echo $most_recent | jq --raw-output '.version' | sed 's/ .*$//')

echo ""
echo "Downloading backup file from Todoist"
curl $backup_url > $filename

echo ""
echo "Uploading backup file to Dropbox"
curl -X POST https://content.dropboxapi.com/2/files/upload \
    --header "Authorization:Bearer $DROPBOX_TOKEN" \
    --header "Dropbox-API-Arg: {\"path\": \"/$timestamp-$filename\",\"mode\": \"add\",\"autorename\": true,\"mute\": false}" \
    --header "Content-Type: application/octet-stream" \
    --data-binary @$filename

rm $filename
