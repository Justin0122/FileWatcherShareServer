#!/bin/bash

user="${USER}"

# Ensure environment variables are properly set
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

# Define the path to the sync script
sync_script="/home/${user}/projects/shell/screenshotShare/sync_screenshots.sh"



# Watch for file creation events in the Screenshots directory
inotifywait -m -e create --format '%f' /home/justin/Pictures/Screenshots |
while read; do
    bash "${sync_script}"
done
