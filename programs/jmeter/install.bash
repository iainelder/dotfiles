#!/bin/bash

# Name: JMeter
# Source: https://dlcdn.apache.org/jmeter/
# Source: https://www.how2shout.com/linux/2-ways-to-install-apache-jmeter-on-ubuntu-22-04-lts-linux/

set -euxo pipefail

cd "$(mktemp --dir)"

sudo apt --yes install \
curl \
default-jre

latest_download="$(
  curl -Ss 'https://dlcdn.apache.org/jmeter/binaries/' \
  | grep -oP '(?<=<a href=")apache-jmeter-.*?\.tgz(?=">)' \
  | tail -1
)"

download_url="https://dlcdn.apache.org/jmeter/binaries/$latest_download"

download_filename=$(
  curl \
  --silent \
  --show-error \
  --url "${download_url}" \
  --location \
  --remote-name \
  --write-out '%{filename_effective}'
)

tar \
--extract \
--auto-compress \
--transform 's:[^/]*:jmeter:' \
--file "$download_filename"

# See Ubuntu wiki for details of the launcher format.
# https://help.ubuntu.com/community/UnityLaunchersAndDesktopFiles
cat > JMeter.desktop <<"EOF"
[Desktop Entry]
Name=JMeter
Type=Application
Exec=/opt/jmeter/bin/jmeter
Icon=/opt/jmeter/docs/images/jmeter_square.png
Terminal=false
EOF

chmod +x JMeter.desktop

# Avoid idempotency error from mv.
# `mv: cannot move ‘jmeter’ to ‘/opt/jmeter’: File exists`
sudo rm -rf /opt/jmeter

sudo mv jmeter /opt/

sudo ln -sf /opt/jmeter/bin/jmeter /usr/local/bin/jmeter

sudo cp JMeter.desktop /usr/share/applications

jmeter -n -v
