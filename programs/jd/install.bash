#!/bin/bash

# Name: jd
# https://github.com/josephburnett/jd/blob/master/README.md

set -euxo pipefail

cd "$(mktemp --dir)"

sudo apt-get update

sudo apt-get --assume-yes install \
curl \
jq

browser_download_url=$(
  curl -Ss 'https://api.github.com/repos/josephburnett/jd/releases/latest' |
  jq -r '.assets[] | select(.name == "jd-amd64-linux") | .browser_download_url'
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

chmod +x "${download_filename}"

sudo mv "${download_filename}" /usr/local/bin/jd

jd --version
