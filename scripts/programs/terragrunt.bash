#!/bin/bash

# Name: Terragrunt
# https://terragrunt.gruntwork.io/docs/getting-started/install/

set -euxo pipefail

cd "$(mktemp --dir)"

sudo apt-get update

sudo apt-get --assume-yes install \
curl \
jq

browser_download_url=$(
  curl -Ss 'https://api.github.com/repos/gruntwork-io/terragrunt/releases/latest' |
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

chmod +x "${download_filename}"

sudo mv "${download_filename}" /usr/local/bin/terragrunt

terragrunt --version
