#!/bin/bash

# Name: awsls
# https://github.com/jckuester/awsls/blob/master/README.md

set -euxo pipefail

cd "$(mktemp --dir)"

sudo apt-get update && sudo apt-get install --yes \
curl

installer_url="https://raw.githubusercontent.com/jckuester/awsls/master/install.sh"

installer_filename=$(
  curl \
  --silent \
  --show-error \
  --url "$installer_url" \
  --location \
  --remote-name \
  --write-out '%{filename_effective}'
)

bash ./"${installer_filename}" -b ~/.local/bin

~/.local/bin/awsls --version
