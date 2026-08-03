#!/bin/bash

# Name: 1Password
# Source: https://support.1password.com/install-linux/

set -euxo pipefail

cd "$(mktemp --dir)"

sudo apt-get update

sudo apt-get --assume-yes install \
curl \
gpg \
lsb-release \
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

# 1Password declares "Depends: libasound2". On 24.04 that name is virtual, and
# apt can satisfy it with liboss4-salsa-asound2, an OSS4 shim whose
# libasound.so.2 resolves under ldd but lacks snd_device_name_get_hint. Name
# the real package so apt cannot pick the shim.
dist="$(lsb_release --release --short)"
if [[ $dist = "24.04" ]]; then
    libasound="libasound2t64"
else
    libasound="libasound2"
fi

# Install 1Password.
sudo apt-get update && sudo apt-get --assume-yes install \
"$libasound" \
1password

# Electron's Chromium sandbox needs namespaces that Docker's seccomp profile
# forbids, so the binary aborts before printing a version. --no-sandbox is
# needed only for this check; running the real app is unaffected.
1password --no-sandbox --version
