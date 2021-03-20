#!/bin/bash

# Name: VirtualBox
# Source: https://www.virtualbox.org/wiki/Linux_Downloads

set -euxo pipefail

cd "$(mktemp --dir)"

sudo apt-get --yes install \
wget \
gnupg

echo "deb [arch=amd64] https://download.virtualbox.org/virtualbox/debian focal contrib" |
sudo tee /etc/apt/sources.list.d/virtualbox.list > /dev/null

wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -

sudo apt-get update
sudo apt-get --yes install \
virtualbox-6.1

# Will also print a warning in Docker: "You will not be able to start VMs"
VBoxManage --version
