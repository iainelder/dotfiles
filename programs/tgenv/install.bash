#!/bin/bash

# Name: tgenv
# Source: https://github.com/cunymatthieu/tgenv/blob/master/README.md

set -euxo pipefail

cd "$(mktemp --dir)"

sudo apt-get update && sudo apt-get install --yes \
git \
curl

repo_url="https://github.com/cunymatthieu/tgenv"
local_path="/opt/tgenv"

if ! test -d "${local_path}"; then
  sudo git clone "${repo_url}" "${local_path}"
else
  sudo git -C "${local_path}" pull
fi

sudo ln --symbolic --force "${local_path}"/bin/* /usr/local/bin

latest="$(tgenv list-remote | head --lines 1)"
sudo tgenv install "${latest}"

tgenv --version

terragrunt --version
