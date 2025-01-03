#!/bin/bash

# Name: AWS Client VPN for Linux
# https://docs.aws.amazon.com/vpn/latest/clientvpn-user/client-vpn-connect-linux.html

set -euxo pipefail

cd "$(mktemp --dir)"

sudo apt-get update

# Installer dependencies
sudo apt-get --assume-yes install \
wget \
lsb-release

dist="$(lsb_release --release --short)"

case "$dist" in
    "24.04")
        libicu="libicu74"
        repo_version="ubuntu"
        ;;
    "22.04")
        libicu="libicu70"
        repo_version="ubuntu"
        ;;
    "20.04")
        libicu="libicu66"
        repo_version="ubuntu-20.04"
        ;;
esac

sudo apt install --assume-yes "$libicu"

# For Docker. Installing the package starts a systemd service.
if [[ $(readlink /sbin/init) != "/lib/systemd/systemd" ]]; then
    sudo apt-get --assume-yes install systemctl
fi

wget -qO- https://d20adtppz83p9s.cloudfront.net/GTK/latest/debian-repo/awsvpnclient_public_key.asc \
| sudo tee /etc/apt/trusted.gpg.d/awsvpnclient_public_key.asc

echo "deb [arch=amd64] https://d20adtppz83p9s.cloudfront.net/GTK/latest/debian-repo $repo_version main" \
| sudo tee /etc/apt/sources.list.d/aws-vpn-client.list

sudo apt-get update

sudo apt-get install awsvpnclient

# I can't find an executable that prints a version.
dpkg -s awsvpnclient | grep "Version: "
