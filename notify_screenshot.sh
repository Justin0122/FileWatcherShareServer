#!/bin/bash

# Ensure environment variables are properly set (~/.bashrc or ~/.zshrc, etc.)
remote_server="${REMOTE_SERVER_FWSS}"
remote_user="${REMOTE_USER_FWSS}"
remote_path="${REMOTE_PATH_FWSS}"
local_screenshot_dir="${LOCAL_SCREENSHOT_DIR_FWSS}"
remote_url="${REMOTE_URL_FWSS}"

# Ensure environment variables are properly set
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

function copy_to_server() {
    rsync -avz -e ssh "${local_screenshot_dir}/" "${remote_user}@${remote_server}:${remote_path}/"
}

inotifywait -m -e create --format '%f' /home/"${USER}"/Pictures/Screenshots |
while read filename; do
    copy_to_server
    url="${remote_url}${filename// /%20}"
    echo "${url} copied to clipboard."
    echo "${url}" | xclip -selection clipboard
done
