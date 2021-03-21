#!/bin/bash

# Name: clustergit
# Source: https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-linux.html

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

sudo ln -sf /opt/clustergit/clustergit /usr/local/bin/clustergit

clustergit --help
