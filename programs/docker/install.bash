#!/bin/bash

# Name: Docker
# https://docs.docker.com/engine/install/ubuntu/

set -euxo pipefail

cd "$(mktemp --dir)"

sudo apt-get update

sudo apt-get install --yes \
    ca-certificates \
    curl

sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

sudo apt-get install --yes \
    docker-ce \
    docker-ce-cli \
    containerd.io \
    docker-buildx-plugin \
    docker-compose-plugin

sudo groupadd -f docker
sudo usermod -aG docker "$USER"
newgrp docker
