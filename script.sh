#!/usr/bin/env bash

source ./secret.env

backup_url=$(curl https://todoist.com/api/v7/backups/get \
    -d token=$TODOIST_TOKEN \
    | jq '.[0].url')

echo $backup_url
