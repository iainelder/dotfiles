#!/bin/bash

# Name: Spotify
# https://www.spotify.com/download/linux/

set -euxo pipefail

cd "$(mktemp --dir)"

sudo apt-get update && sudo apt-get install --yes \
curl \
gnupg

curl -sS https://download.spotify.com/debian/pubkey_C85668DF69375001.gpg |
sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg

echo "deb http://repository.spotify.com stable non-free" |
sudo tee /etc/apt/sources.list.d/spotify.list

sudo apt-get update

source /etc/os-release

if [[ $VERSION_ID == "24.04" ]]; then
    sudo apt-get install --yes libasound2t64
fi

sudo apt-get install --yes spotify-client

spotify --version
