#!/bin/bash

# Name: PowerShell
# Source: https://docs.microsoft.com/es-es/powershell/scripting/install/installing-powershell-core-on-linux?view=powershell-7.1#ubuntu-2004

set -euxo pipefail

cd "$(mktemp --dir)"

sudo apt-get install --yes \
curl \
software-properties-common

package="https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb"

download_filename=$(
  curl \
  --silent \
  --show-error \
  --url "$package" \
  --location \
  --remote-name \
  --write-out '%{filename_effective}'
)

sudo dpkg -i "${download_filename}"

sudo apt-get update

sudo add-apt-repository universe

sudo apt-get install --yes powershell

pwsh --version