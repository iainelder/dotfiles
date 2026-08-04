#!/bin/bash

# Name: Parallel
# https://www.gnu.org/software/parallel/

set -euxo pipefail

cd "$(mktemp --dir)"

sudo apt-get update

# Installer dependencies. tar shells out to bzip2
sudo apt-get --assume-yes install \
curl \
make \
bzip2

# parallel-latest.tar.bz2 is empty on the server, so take the newest dated release.
release=$(
  curl -Ss 'https://ftp.gnu.org/gnu/parallel/' |
  grep -oP 'parallel-\d{8}\.tar\.bz2' |
  sort --unique |
  tail --lines 1
)

browser_download_url="https://ftp.gnu.org/gnu/parallel/$release"

download_filename=$(
  curl \
  --silent \
  --show-error \
  --url "$browser_download_url" \
  --location \
  --remote-name \
  --write-out '%{filename_effective}'
)

tar --extract --auto-compress --file "$download_filename" --strip-components 1

# Steps found in extracted README.
./configure
make
sudo make install

# make installs GNU Parallel to /usr/local/bin/parallel
# APT package moreutils installs a different tool to /usr/bin/parallel.
# If the moreutils version is installed, grep exits 0; otherwise it exits 1.
# set allows Bash to continue on a non-zero exit code for this part.
set +e
grep -b "for each argument, run command with argument, in parallel" /usr/bin/parallel
is_moreutils="$?"
set -e

# The default PATH setting gives priority to the moreutils version.
# So move it in the same way that APT package parallel (for GNU Parallel) does.
if test 0 = "$is_moreutils"; then
  sudo mv /usr/bin/parallel /usr/bin/parallel.moreutils
  printf "Moved moreutils version of parallel to /usr/bin/parallel.moreutils to avoid conflict." >&2
fi

# Silence a citation notice on every invocation.
mkdir --parents ~/.parallel
touch ~/.parallel/will-cite

parallel --version
