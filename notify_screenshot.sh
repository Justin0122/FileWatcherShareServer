#!/bin/bash

# Ensure environment variables are properly set
remote_server="${REMOTE_SERVER_FWSS}"
remote_user="${REMOTE_USER_FWSS}"
remote_path="${REMOTE_PATH_FWSS}"
local_screenshot_dir="${LOCAL_SCREENSHOT_DIR_FWSS}"
local_video_dir="${LOCAL_VIDEO_DIR_FWSS}"
remote_url="${REMOTE_URL_FWSS}"

export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

function sync_screenshots() {
    if [ -n "$local_screenshot_dir" ]; then
        inotifywait -m -e create --format '%f' "$local_screenshot_dir" |
        while read filename; do
            rsync -avz -e ssh "${local_screenshot_dir}/${filename}" "${remote_user}@${remote_server}:${remote_path}/images/"
            filename="${filename// /%20}"
            echo "${remote_url}images/${filename}" | xclip -selection clipboard
        done
    else
        echo "Local screenshot directory not set. Exiting..."
        exit 1
    fi
}

function sync_videos() {
    if [ -n "$local_video_dir" ]; then
        inotifywait -m -e create --format '%f' "$local_video_dir" |
        while read filename; do
            rsync -avz -e ssh "${local_video_dir}/${filename}" "${remote_user}@${remote_server}:${remote_path}/videos/"
            filename="${filename// /%20}"
            echo "${remote_url}video/${filename}" | xclip -selection clipboard
        done
    else
        echo "Local video directory not set. Exiting..."
        exit 1
    fi
}

# Run functions only if the directories are set
if [ -n "$local_screenshot_dir" ]; then
    sync_screenshots &
fi

if [ -n "$local_video_dir" ]; then
    sync_videos &
fi

# Keep the script running
wait
