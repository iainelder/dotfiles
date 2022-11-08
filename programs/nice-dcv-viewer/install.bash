#!/bin/bash

# Name: NICE DCV Viewer
# https://www.nice-dcv.com/latest.html

set -euxo pipefail

cd "$(mktemp --dir)"

sudo apt-get update

# Installer dependencies
sudo apt-get --assume-yes install \
curl

# Load DISTRIB_RELEASE environment variable.
source /etc/lsb-release

if [[ "$DISTRIB_RELEASE" == "20.04" ]]; then
    package_url="https://d1uj6qtbmh3dt5.cloudfront.net/nice-dcv-viewer_amd64.ubuntu2004.deb"
elif [[ "$DISTRIB_RELEASE" == "22.04" ]]; then
    package_url="https://d1uj6qtbmh3dt5.cloudfront.net/nice-dcv-viewer_amd64.ubuntu2204.deb"
fi

download_filename=$(
  curl \
  --silent \
  --show-error \
  --url "$package_url" \
  --location \
  --remote-name \
  --write-out '%{filename_effective}'
)

sudo apt install --yes "./$download_filename"

dcvviewer --version
