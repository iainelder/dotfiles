#!/bin/bash

# Name: Introspector
# https://github.com/goldfiglabs/introspector/blob/main/README.md

set -euxo pipefail

tmp="$(mktemp --dir)"

sudo apt-get update

sudo apt-get --assume-yes install \
curl \
unzip

browser_download_url="https://github.com/goldfiglabs/introspector/releases/latest/download/introspector_linux.zip"

download_filename="$(
  cd "${tmp}"
  curl \
  --silent \
  --show-error \
  --url "${browser_download_url}" \
  --location \
  --remote-name \
  --write-out "${tmp}/%{filename_effective}"
)"

unzip "${download_filename}" -d "${tmp}"
rm "${download_filename}"
sudo mv "${tmp}" /opt/introspector

sudo ln -sfv /opt/introspector/introspector /usr/local/bin/introspector

sudo introspector

# FIXME: install docker as level 1 dependency
# FIXME: install pipx as level 1 dependency
sudo apt-get --assume-yes install \
docker.io \
python3-pip \
python3-venv

sudo pip3 install pipx

sudo \
PIPX_HOME=/opt/pipx \
PIPX_BIN_DIR=/usr/local/bin \
pipx install docker-compose

# FIXME: enable rootless docker
# (cd /opt/introspector && sudo docker-compose up --detach)


# sudo apt install vim
# vim ~/.aws/credentials

# sudo ./introspector init
# sudo AWS_SHARED_CREDENTIALS_FILE=~/.aws/credentials AWS_PROFILE=introspector ./introspector account aws import
# sudo AWS_SHARED_CREDENTIALS_FILE=~/.aws/credentials AWS_PROFILE=introspector-secdel ./introspector account aws import
