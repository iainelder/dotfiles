#!/bin/bash

# Name: SnowSQL
# Source: https://docs.snowflake.com/en/user-guide/snowsql-install-config.html#installing-snowsql-on-linux-using-the-installer

set -euxo pipefail

cd "$(mktemp --dir)"

sudo apt-get update && sudo apt-get install --yes \
curl \
gpg \
unzip

# TODO: get the latest installer URL from this URL
# versions_page="https://sfc-repo.snowflakecomputing.com/snowsql/bootstrap/1.2/linux_x86_64/index.html"

installer_url="https://sfc-repo.snowflakecomputing.com/snowsql/bootstrap/1.2/linux_x86_64/snowsql-1.2.11-linux_x86_64.bash"

installer_filename=$(
  curl \
  --silent \
  --show-error \
  --url "$installer_url" \
  --location \
  --remote-name \
  --write-out '%{filename_effective}'
)

signature_url="https://sfc-repo.snowflakecomputing.com/snowsql/bootstrap/1.2/linux_x86_64/snowsql-1.2.11-linux_x86_64.bash.sig"

signature_filename=$(
  curl \
  --silent \
  --show-error \
  --url "$signature_url" \
  --location \
  --remote-name \
  --write-out '%{filename_effective}'
)

# The original instructions used keys.gpg.net. That hostname no longer resolves.
# Don't use keys.openpgp.org. It strips the user ID required for verification.
# Thanks to @Matthew_1P from the 1Password forums for a clear explanation.
# https://1password.community/discussion/114834/cant-verify-pgp-on-cli-tools
gpg --keyserver hkps://keyserver.ubuntu.com --recv-keys 37C7086698CB005C

gpg --verify "$signature_filename" "$installer_filename"

sudo \
SNOWSQL_DEST=/usr/local/bin \
SNOWSQL_LOGIN_SHELL=/dev/null \
bash "$installer_filename"

# WTF? Regardless of where you set the SNOWSQL_DEST, the installer appears to
# write the libraries to ~/.snowsql.
# And the libz.so.1 library doesn't work, so we need to use the system one
# instead.
# FIXME Install SnowSQL to system folder to avoid this madness
# ln -sf /usr/lib/x86_64-linux-gnu/libz.so.1 ~/.snowsql/1.2.11/libz.so.1

LC_ALL=C.UTF-8 \
LANG=C.UTF-8 \
snowsql --version
