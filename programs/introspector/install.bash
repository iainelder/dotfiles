#!/bin/bash

# Name: Terragrunt
# https://terragrunt.gruntwork.io/docs/getting-started/install/

set -euxo pipefail

cd "$(mktemp --dir)"

sudo apt-get update

sudo apt-get --assume-yes install \
curl \
unzip

browser_download_url="https://github.com/goldfiglabs/introspector/releases/latest/download/introspector_linux.zip"

download_filename=$(
  curl \
  --silent \
  --show-error \
  --url "$browser_download_url" \
  --location \
  --remote-name \
  --write-out '%{filename_effective}'
)

unzip "${download_filename}"

sudo apt-get --assume-yes install \
docker.io \
python3-pip \
python3-venv

sudo pip3 install pipx

sudo \
PIPX_HOME=/opt/pipx \
PIPX_BIN_DIR=/usr/local/bin \
pipx install docker-compose

docker-compose up -d

sudo apt install vim
vim ~/.aws/credentials

sudo ./introspector init
sudo AWS_SHARED_CREDENTIALS_FILE=~/.aws/credentials AWS_PROFILE=introspector ./introspector account aws import
