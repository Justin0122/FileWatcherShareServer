# Screenshot Share

This repository contains scripts to automate the sharing of screenshots from a local directory to a remote server. The system watches for new screenshots in a designated folder and syncs them to a specified location on a remote server using `rsync` over SSH. Additionally, it copies the URL of the uploaded screenshot to the clipboard for easy sharing.

## Usage

### notify_screenshot.sh

This script utilizes inotify to watch for new files created in the specified directory (`/home/${USER}/Pictures/Screenshots`). When a new file is created, it triggers the `sync_screenshot.sh` script to sync the screenshot to the remote server.

### sync_screenshot.sh

Responsible for syncing the most recent screenshot from the local directory to a remote server. It retrieves the latest screenshot, syncs it via `rsync` over SSH to the specified remote server path, and generates a URL for the image hosted on the remote server. The URL is then copied to the clipboard for easy access.

## Configuration

Ensure the following environment variables are correctly set before executing the scripts:

- `REMOTE_SERVER_FWSS`: The IP address or hostname of the remote server.
- `REMOTE_USER_FWSS`: The username to access the remote server.
- `REMOTE_PATH_FWSS`: The path on the remote server where the screenshots will be stored.
- `LOCAL_SCREENSHOT_DIR_FWSS`: The local directory where screenshots are captured.
- `REMOTE_URL_FWSS`: The base URL where the screenshots will be accessible.

### Example Configuration:

```bash
export REMOTE_SERVER_FWSS="192.1.1.1"
export REMOTE_USER_FWSS="pi"
export REMOTE_PATH_FWSS="/var/www/html/server"
export LOCAL_SCREENSHOT_DIR_FWSS="/home/${USER}/Pictures/Screenshots"
export REMOTE_URL_FWSS="https://example.com/screenshots"
```

## Dependencies

- `inotify-tools`
- `xclip`
- `rsync`
- `ssh`

## Server setup

The following steps are required to setup the remote server to receive the screenshots:

1. Copy the `server` directory to the remote server. This directory contains the index.js file which is responsible for serving the screenshots. It also contains a `images` directory which is where the screenshots will be stored.
2. Install the dependencies for the server by running `npm install` in the `server` directory.
3. Start the server by running `npm start` in the `server` directory.
4. Ensure the server is accessible from the internet. Set up apache or nginx to proxy requests to the server if necessary, or use a service like [ngrok](https://ngrok.com/) to expose the server to the internet if desired.


## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

