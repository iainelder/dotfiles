#!/bin/bash

# Name: clustergit
# Source: https://github.com/mnagel/clustergit/blob/master/README.md

set -euxo pipefail

cd "$(mktemp --dir)"

sudo apt-get install --yes \
curl

browser_download_url="https://raw.githubusercontent.com/mnagel/clustergit/master/clustergit"

download_filename=$(
  curl \
  --silent \
  --show-error \
  --url "$browser_download_url" \
  --location \
  --remote-name \
  --write-out '%{filename_effective}'
)

# Application dependencies.
sudo apt-get install --yes \
python3

sudo install "$download_filename" /usr/local/bin/clustergit

clustergit --help
