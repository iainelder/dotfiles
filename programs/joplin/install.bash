#!/bin/bash

# Name: Anki
# https://apps.ankiweb.net/
# https://github.com/ankitects/anki/releases
# https://gist.github.com/lukechilds/a83e1d7127b78fef38c2914c4ececc3c#gistcomment-2574561

set -euxo pipefail

cd "$(mktemp --dir)"

sudo apt-get update

# Installer dependencies
sudo apt-get --assume-yes install \
wget 

# https://joplinapp.org/help/#desktop-applications
wget -O - https://raw.githubusercontent.com/laurent22/joplin/dev/Joplin_install_and_update.sh | bash

# Application dependencies
# linux-image-* installs fuse-module. How does the container work at all without a linux image?
sudo apt --assume-yes install \
"linux-image-$(uname --kernel-release)" \
fuse \
libgtk2.0-0 \
libxshmfence1 \
libnss3 \
libatk-bridge2.0-0 \
libdrm2 \
libgtk-3-0 \
libgbm1 \
libasound2

# FIXME: See test_fuse.bash
~/.joplin/Joplin.AppImage

# TODO: Get the GUI working locally.
# https://gursimar27.medium.com/run-gui-applications-in-a-docker-container-ca625bad4638
