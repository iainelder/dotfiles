#!/bin/bash

# Name: clustergit
# Source: https://github.com/mnagel/clustergit/blob/master/README.md

set -euxo pipefail

cd "$(mktemp --dir)"

sudo apt-get install --yes \
git

repo_url="https://github.com/mnagel/clustergit"
local_path="/opt/clustergit"

if ! test -d "${local_path}"; then
  sudo git clone "${repo_url}" "${local_path}"
else
  sudo git -C "${local_path}" pull
fi

sudo apt-get install --yes \
python3

sudo ln -sf "${local_path}"/clustergit /usr/local/bin/clustergit

clustergit --help
