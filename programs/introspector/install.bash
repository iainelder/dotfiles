#!/bin/bash

# Name: Introspector
# Source: https://github.com/goldfiglabs/introspector/blob/main/README.md
# Local: Add this option to the docker run command: --volume "${HOME}/.aws/:/etc/opt/aws"

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

# FIXME: panic: Could not find Introspector CLI container running
# FIXME: report version if container isn't running?
# sudo introspector

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
# FIXME: Launch as a service
# FIXME: Can't we run serverless? Sqlite instead of PostgreSQL?
(cd /opt/introspector && sudo docker-compose up --detach)

# sudo apt install vim
# vim ~/.aws/credentials

sudo introspector init

# export AWS_SHARED_CREDENTIALS_FILE=/etc/opt/aws/credentials
# export AWS_CONFIG_FILE=/etc/opt/aws/config

# sudo \
# --preserve-env=AWS_SHARED_CREDENTIALS_FILE,AWS_CONFIG_FILE \
# AWS_PROFILE=introspector \
# -- \
# introspector account aws import


# sudo \
# --preserve-env=AWS_SHARED_CREDENTIALS_FILE,AWS_CONFIG_FILE \
# AWS_PROFILE=introspector-secdel \
# -- \
# introspector account aws import --help
