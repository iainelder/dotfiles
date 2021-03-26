#!/bin/bash

# Name: git-secrets
# https://github.com/awslabs/git-secrets

set -euxo pipefail

cd "$(mktemp --dir)"

sudo apt-get update && sudo apt-get install --yes \
git \
make

repo_url="https://github.com/awslabs/git-secrets.git"

local_path="/opt/git-secrets"

sudo mkdir --parents "${local_path}"

sudo git -C "$(dirname ${local_path})" clone "${repo_url}" || \
sudo git -C "${local_path}" pull

(cd "${local_path}" && sudo make install)

# Test basic commands on self

git init

git secrets --install

git secrets --register-aws
