#!/bin/bash

# https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-linux.html

set -euxo pipefail

cd "$(mktemp --dir)"

sudo apt-get install --yes \
curl \
jq \
unzip

latest_version=$(
  curl -Ss 'https://api.github.com/repos/aws/aws-cli/tags' |
  jq -r 'map(select(.name | startswith("2.")))[0].name'
)

echo $latest_version

if command -v aws > /dev/null ; then
  current_version="$(aws --version | cut -d' ' -f 1 | cut -d'/' -f 2)"
else
  current_version=0
fi

dpkg --compare-versions $current_version ge $latest_version && {
  aws --version
  exit 0
}

download_url='https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip'

download_filename=$(
  curl \
  --silent \
  --show-error \
  --url "$download_url" \
  --location \
  --remote-name \
  --write-out '%{filename_effective}'
)

unzip -q $download_filename

sudo ./aws/install --update

aws --version
