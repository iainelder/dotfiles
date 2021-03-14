#!/bin/bash

# Name: PowerShell
# Source: https://docs.microsoft.com/es-es/powershell/scripting/install/installing-powershell-core-on-linux?view=powershell-7.1#ubuntu-2004

set -euxo pipefail

cd "$(mktemp --dir)"

# for tzdata via software-properties-common
export DEBIAN_FRONTEND=noninteractive

apt-get update && apt-get install --yes \
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

dpkg -i $download_filename

apt-get update

add-apt-repository universe

apt-get install --yes powershell

pwsh --version