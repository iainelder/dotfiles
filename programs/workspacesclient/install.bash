#!/bin/bash

# Name: AWS Workspaces Client
# https://clients.amazonworkspaces.com/linux-install.html

set -euxo pipefail

cd "$(mktemp --dir)"

sudo apt-get update && sudo apt-get install --yes \
wget \
gnupg

wget -q -O - https://workspaces-client-linux-public-key.s3-us-west-2.amazonaws.com/ADB332E7.asc | sudo apt-key add -

echo "deb [arch=amd64] https://d3nt0h4h6pmmc4.cloudfront.net/ubuntu bionic main" |
sudo tee /etc/apt/sources.list.d/amazon-workspaces-clients.list 

sudo apt-get update

# apt-file update
# apt-file list workspacesclient

# For tzdata and keyboard-configuration
export DEBIAN_FRONTEND=noninteractive

sudo --preserve-env apt-get install --yes \
workspacesclient

# The command ignores the --version option and produces an error
# 
# Unable to init server: Could not connect: Connection refused
# (workspacesclient:13161): Gtk-WARNING **: 15:19:36.932: cannot open display: 
file /opt/workspacesclient/workspacesclient
