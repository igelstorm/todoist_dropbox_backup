# Back up Todoist to Dropbox

If you have a Todoist Premium account, Todoist automatically creates a full
backup of your data every day. This script uses the Todoist and Dropbox APIs
to download the most recent backup and upload it to Dropbox.

You'll need to set some credentials in `secret.env` (probably a good idea to
`chmod 600 secret.env`):

```
TODOIST_TOKEN=my_token
DROPBOX_TOKEN=my_token
```

* Get a Todoist token from `Settings/Integrations`
* Get a Dropbox token [here](https://www.dropbox.com/developers/apps)
  * Use the "App folder" permission type to limit access to a folder under
    `/Apps`.  This means files ostensibly uploaded to the root folder actually
    end up in the application folder.
