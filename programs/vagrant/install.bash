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

# At version 2.3.0 the name format of the deb package changed.
# It also looks like they hid the normal release version and replaced it with a
# patched release. So fetch whatever the name of the 64-bit deb package is.
deb_package="$(
  curl -Ss "https://releases.hashicorp.com/vagrant/${latest_version}/" |
  grep -oP "(?<=>)vagrant_.*?_(x86_64|amd64)\.deb(?=</a>)"
)"

package_url="https://releases.hashicorp.com/vagrant/${latest_version}/${deb_package}"

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
