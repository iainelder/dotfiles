#!/bin/bash

# Name: Zoom
# https://us05web.zoom.us/download
# deb-get supports Zoom. You should use that instead.
# https://github.com/wimpysworld/deb-get/tree/main/01-main

set -euxo pipefail

cd "$(mktemp --dir)"

sudo apt-get update

# Installer dependencies
sudo apt-get --assume-yes install \
curl \
jq \
wget

version=$(
    curl -Ss 'https://us05web.zoom.us/rest/download?os=linux' \
    | jq -r '.result.downloadVO.zoom.version'
)

wget "https://us05web.zoom.us/client/$version/zoom_amd64.deb"

# "Fix broken" really means "install missing dependencies".
sudo apt-get install --yes --fix-broken ./zoom_amd64.deb

apt-cache show zoom | grep Version
