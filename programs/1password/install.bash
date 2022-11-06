#!/bin/bash

# Name: 1Password
# Source: https://support.1password.com/install-linux/

set -euxo pipefail

cd "$(mktemp --dir)"

sudo apt-get update

sudo apt-get --assume-yes install \
curl \
gpg \
moreutils # Provides sponge.

# Add the key for the 1Password apt repository.
curl -sS https://downloads.1password.com/linux/keys/1password.asc |
gpg --dearmor --output - |
sudo sponge /usr/share/keyrings/1password-archive-keyring.gpg

# Add the 1Password apt repository.
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/1password-archive-keyring.gpg] https://downloads.1password.com/linux/debian/amd64 stable main' |
sudo tee /etc/apt/sources.list.d/1password.list

# Add the debsig-verify policy.
sudo mkdir -p /etc/debsig/policies/AC2D62742012EA22/
curl -sS https://downloads.1password.com/linux/debian/debsig/1password.pol |
sudo sponge /etc/debsig/policies/AC2D62742012EA22/1password.pol

sudo mkdir -p /usr/share/debsig/keyrings/AC2D62742012EA22

curl -sS https://downloads.1password.com/linux/keys/1password.asc |
gpg --dearmor --output - |
sudo sponge /usr/share/debsig/keyrings/AC2D62742012EA22/debsig.gpg

# Install 1Password.
sudo apt-get update && sudo apt-get --assume-yes install \
1password

# In a Docker container the 1password executable fails with what appears to be
# insufficient privileges. So just check that the package is installed in apt.
apt-cache show 1password
