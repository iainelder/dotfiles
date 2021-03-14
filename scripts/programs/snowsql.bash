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

gpg --keyserver hkp://keys.gnupg.net --recv-keys 37C7086698CB005C

gpg --verify "$signature_filename" "$installer_filename"

sudo \
SNOWSQL_DEST=/usr/local/bin \
SNOWSQL_LOGIN_SHELL=/dev/null \
bash "$installer_filename"

LC_ALL=C.UTF-8 \
LANG=C.UTF-8 \
snowsql --version
