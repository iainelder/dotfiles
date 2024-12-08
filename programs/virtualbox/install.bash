#!/bin/bash

# Name: VirtualBox
# Source: https://www.virtualbox.org/wiki/Linux_Downloads

set -euxo pipefail

cd "$(mktemp --dir)"

sudo apt-get --yes install \
wget \
gnupg \
lsb-release \
moreutils # Provides sponge.

dist=$(lsb_release --codename --short)

key="/usr/share/keyrings/oracle-virtualbox-2016.gpg"

echo "deb [arch=amd64 signed-by=$key] https://download.virtualbox.org/virtualbox/debian $dist contrib" \
| sudo sponge /etc/apt/sources.list.d/virtualbox.list

wget -q -O- https://www.virtualbox.org/download/oracle_vbox_2016.asc \
| sudo gpg --dearmor --yes --output "$key"

sudo apt-get update
sudo apt-get --yes install \
virtualbox-7.1

# Will also print a warning in Docker: "You will not be able to start VMs"
VBoxManage --version
