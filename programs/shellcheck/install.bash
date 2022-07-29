#!/bin/bash

# Name: ShellCheck
# https://www.shellcheck.net/

set -euxo pipefail

cd "$(mktemp --dir)"

sudo apt-get update

# Installer dependencies
sudo apt-get --assume-yes install \
curl \
jq \
xz-utils

browser_download_url=$(
  curl -Ss 'https://api.github.com/repos/koalaman/shellcheck/releases/latest' |
  jq -r '.assets[] | select(.name | test("linux.x86_64.tar.xz")) | .browser_download_url'
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

tar --extract --xz --file $download_filename

extract_folder="$(find . -mindepth 1 -maxdepth 1 -type d)"

sudo cp "$extract_folder/shellcheck" /usr/local/bin

shellcheck --version
