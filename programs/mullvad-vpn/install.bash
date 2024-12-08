#!/bin/bash

# Name: Mullvad VPN
# https://mullvad.net/en/download/vpn/linux

set -euxo pipefail

cd "$(mktemp --dir)"

sudo apt-get update

# Installer dependencies
sudo apt-get --assume-yes install \
curl \
lsb-release

# Download the Mullvad signing key
sudo curl -fsSLo /usr/share/keyrings/mullvad-keyring.asc https://repository.mullvad.net/deb/mullvad-keyring.asc

arch=$( dpkg --print-architecture )
release=$(lsb_release -cs)

# Add the Mullvad repository server to apt
echo "deb [signed-by=/usr/share/keyrings/mullvad-keyring.asc arch=${arch}] https://repository.mullvad.net/deb/stable ${release} main" | sudo tee /etc/apt/sources.list.d/mullvad.list

# Install the package
sudo apt update

# Undeclared dependency.
sudo apt install --assume-yes apparmor-profiles

sudo apt install --assume-yes mullvad-vpn

mullvad --version
