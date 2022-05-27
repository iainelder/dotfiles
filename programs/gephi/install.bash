#!/bin/bash

# Name: Gephi
# https://gephi.org/

set -euxo pipefail

cd "$(mktemp --dir)"

sudo apt-get update

# Installer dependencies
sudo apt-get --assume-yes install \
curl \
jq

browser_download_url=$(
  curl -Ss 'https://api.github.com/repos/gephi/gephi/releases/latest' |
  jq -r '.assets[] | select(.name | test("linux-x64.tar.gz")) | .browser_download_url'
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

tar --extract --auto-compress --file "$download_filename"

extract_folder=$(basename "$download_filename" "-linux-x64.tar.gz")

sudo mv "${extract_folder}" /opt/gephi

sudo ln -sf /opt/gephi/bin/gephi /usr/local/bin/gephi

# There is no `--version` option. Any of the `org.gephi` modules report the
# public version.
#
# In a graphical environment this actually launches the GUI. The GUI needs to be
# closed for the version number to appear and this script to complete.
gephi --modules --list | grep org.gephi.welcome.screen | awk '{print $2}'
