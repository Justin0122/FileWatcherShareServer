#!/bin/bash

# Ensure environment variables are properly set (~/.bashrc or ~/.zshrc, etc.)
remote_server="${REMOTE_SERVER_FWSS}"
remote_user="${REMOTE_USER_FWSS}"
remote_path="${REMOTE_PATH_FWSS}"
local_screenshot_dir="${LOCAL_SCREENSHOT_DIR_FWSS}"
remote_url="${REMOTE_URL_FWSS}"

rsync -avz -e ssh "${local_screenshot_dir}/" "${remote_user}@${remote_server}:${remote_path}/"

cd "${local_screenshot_dir}"
latest_image=$(ls -t "${local_screenshot_dir}"/Screenshot* | head -n1)
if [ -n "$latest_image" ]; then
    image_name=$(basename "${latest_image%.*}")
    url="${remote_url}${image_name}.png"; url="${url// /%20}"
    echo "${url}" | xclip -selection clipboard
else
    echo "No Screenshot image found."
fi
