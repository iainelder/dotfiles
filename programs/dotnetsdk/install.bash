#!/bin/bash

# Name: .NET SDK
# https://learn.microsoft.com/en-us/dotnet/core/install/linux-ubuntu

set -euxo pipefail

cd "$(mktemp --dir)"

sudo apt-get update

# Installer dependencies
sudo apt-get --assume-yes install \
wget \
lsb-release

dist="$(lsb_release --release --short)"

wget "https://packages.microsoft.com/config/ubuntu/$dist/packages-microsoft-prod.deb" -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb

sudo apt-get update

sudo apt-get install -y dotnet-sdk-7.0

dotnet --version
