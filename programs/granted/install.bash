#!/bin/bash

# Name: Granted
# https://github.com/common-fate/granted

set -euxo pipefail

cd "$(mktemp --dir)"

sudo apt-get update

# Installer dependencies
sudo apt-get --assume-yes install \
curl \
jq

latest_version=$(
  curl -Ss 'https://api.github.com/repos/common-fate/granted/releases/latest' |
  jq -r '.tag_name'
)

v_stripped=${latest_version#v}

browser_download_url="releases.commonfate.io/granted/${latest_version}/granted_${v_stripped}_linux_x86_64.tar.gz"

download_filename=$(
  curl \
  --silent \
  --show-error \
  --url "$browser_download_url" \
  --location \
  --remote-name \
  --write-out '%{filename_effective}'
)

tar --extract --auto-compress --file "$download_filename"

sudo cp assume assumego granted /usr/local/bin

granted --version
