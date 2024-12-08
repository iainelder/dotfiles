#!/bin/bash

# Name: AWS Workspaces Client
# https://clients.amazonworkspaces.com/linux-install.html

set -euxo pipefail

cd "$(mktemp --dir)"

sudo apt-get update && sudo apt-get install --yes \
wget \
gnupg \
moreutils # Provides sponge.

key="/usr/share/keyrings/workspaces-client-linux-public-key.gpg"

wget -q -O - https://workspaces-client-linux-public-key.s3-us-west-2.amazonaws.com/ADB332E7.asc \
| sudo gpg --dearmor --yes --output "$key"

source /etc/os-release
case "$VERSION_ID" in
    "24.04")
        # The apt repo server gives a 403 error for "noble".
        codename="jammy"
        ;;
    *):
        codename="$VERSION_CODENAME"
        ;;
esac

echo "deb [arch=amd64 signed-by=$key] https://d3nt0h4h6pmmc4.cloudfront.net/ubuntu $codename main" \
| sudo sponge /etc/apt/sources.list.d/amazon-workspaces-clients.list

sudo apt-get update

# For tzdata and keyboard-configuration
export DEBIAN_FRONTEND=noninteractive

sudo --preserve-env apt-get install --yes \
workspacesclient

dpkg --status workspacesclient | grep -oP '(?<=Version: ).*'
