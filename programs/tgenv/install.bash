#!/bin/bash

# Name: tgenv
# Source: https://github.com/taosmountain/tgenv/blob/main/README.md

# See this Github issue for why I changed the implementation:
# https://github.com/cunymatthieu/tgenv/issues/11#issuecomment-812067189

set -euxo pipefail

cd "$(mktemp --dir)"

sudo apt-get update && sudo apt-get install --yes \
git \
curl

repo_url="https://github.com/tgenv/tgenv"
local_path="/opt/tgenv"

if ! test -d "${local_path}"; then
  sudo git clone "${repo_url}" "${local_path}"
else
  sudo git -C "${local_path}" pull
fi

sudo ln --symbolic --force "${local_path}"/bin/* /usr/local/bin

sudo tgenv install latest

sudo tgenv use latest

tgenv --version

terragrunt --version
