#!/bin/bash

# Name: PlantUML
# https://plantuml.com/faq-install

set -euxo pipefail

cd "$(mktemp --dir)"

sudo apt-get update

# Installer dependencies
sudo apt-get --assume-yes install \
curl \
jq

browser_download_url=$(
  curl -Ss 'https://api.github.com/repos/plantuml/plantuml/releases/latest' \
  | jq -r '.assets[] | select(.name | test("^plantuml.jar$")) | .browser_download_url'
)

download_filename=$(
  curl \
  --silent \
  --show-error \
  --url "$browser_download_url" \
  --location \
  --remote-name \
  --write-out '%{filename_effective}'
)

# Application dependencies
sudo apt-get --assume-yes install \
default-jre

sudo mkdir --parents /opt/plantuml
sudo cp plantuml.jar /opt/plantuml

cat > plantuml <<"EOF"
java -jar /opt/plantuml/plantuml.jar "$@"
EOF

chmod +x plantuml

sudo cp plantuml /usr/local/bin

plantuml -authors
