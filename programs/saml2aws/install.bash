#!/bin/bash

# Name: saml2aws
# https://github.com/Versent/saml2aws

set -euxo pipefail

cd "$(mktemp --dir)"

sudo apt-get update

# Installer dependencies
sudo apt-get --assume-yes install \
curl \
jq \
lsb-release

dist=$(lsb_release --codename --short)

if [[ "$dist" = "focal" ]]; then
  # Last version to support Ubuntu 20.04.
  # See https://github.com/Versent/saml2aws/issues/1010
  version="tags/v2.36.4"
else
  version="latest"
fi

browser_download_url=$(
  curl -Ss "https://api.github.com/repos/Versent/saml2aws/releases/$version" |
  jq -r '.assets[] | select(.name | test("linux_amd64")) | .browser_download_url'
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

tar --extract --gzip --file "$download_filename"

sudo cp saml2aws /usr/local/bin

saml2aws --version
