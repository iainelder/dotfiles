#!/bin/bash

# Name: Rocketchat
# https://github.com/RocketChat/Rocket.Chat.Electron

set -euxo pipefail

cd "$(mktemp --dir)"

sudo apt-get update

# Installer dependencies
sudo apt-get --assume-yes install \
curl \
jq

browser_download_url=$(
  curl -Ss 'https://api.github.com/repos/RocketChat/Rocket.Chat.Electron/releases/latest' |
  jq -r '.assets[] | select(.name | test("linux-amd64.deb")) | .browser_download_url'
)

download_filename=$(
  curl \
  --silent \
  --show-error \
  --url "$browser_download_url" \
  --location \
  --remote-name \
  --write-out '%{filename_effective}'
)

sudo apt-get --assume-yes install "./$download_filename"

dpkg --status rocketchat | grep -oP '(?<=Version: ).*'
