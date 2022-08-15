#!/bin/bash

# Name: Visual Studio Code
# Source: https://code.visualstudio.com/docs/setup/linux

set -euxo pipefail

cd "$(mktemp --dir)"

sudo apt-get install --yes \
curl \
gnupg

package="https://go.microsoft.com/fwlink/?LinkID=760868"

download_filename="$(
  curl \
  --silent \
  --show-error \
  --url "${package}" \
  --location \
  --output "vscode.deb" \
  --write-out '%{filename_effective}'
)"

sudo apt-get install --yes "./${download_filename}"

code --version
