#!/bin/bash

# Name: Vagrant
# Source: https://www.vagrantup.com/downloads

set -euxo pipefail

cd "$(mktemp --dir)"

sudo apt --yes install \
curl

latest_version="$(
  curl -Ss 'https://releases.hashicorp.com/vagrant/' |
  grep -oP '(?<=vagrant_).*?(?=</a>)' |
  head -n 1
)"

package_url="https://releases.hashicorp.com/vagrant/${latest_version}/vagrant_${latest_version}_x86_64.deb"

package_filename=$(
  curl \
  --silent \
  --show-error \
  --url "${package_url}" \
  --location \
  --remote-name \
  --write-out '%{filename_effective}'
)

sudo apt-get install "./${package_filename}"

vagrant --version
