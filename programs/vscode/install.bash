#!/bin/bash

# Name: Visual Studio Code
# Source: https://code.visualstudio.com/docs/setup/linux

set -euxo pipefail

cd "$(mktemp --dir)"

sudo apt-get install --yes \
curl

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

sudo apt install --yes "./${download_filename}"

# Normally you would use `code --version` to check the version.
# But it fails with an X11 error in a non-GUI environment.
# This is good enough because it proves that the package is installed
# via apt.
apt-cache policy code
