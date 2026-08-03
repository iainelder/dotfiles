#!/bin/bash

# Name: Claude Desktop
# https://code.claude.com/docs/en/desktop-linux

set -euxo pipefail

cd "$(mktemp --dir)"

sudo apt-get update

# Installer dependencies
sudo apt-get --assume-yes install \
curl \
gnupg

sudo curl -fsSLo /usr/share/keyrings/claude-desktop-archive-keyring.asc https://downloads.claude.ai/claude-desktop/key.asc

echo "deb [arch=amd64,arm64 signed-by=/usr/share/keyrings/claude-desktop-archive-keyring.asc] https://downloads.claude.ai/claude-desktop/apt/stable stable main" |
sudo tee /etc/apt/sources.list.d/claude-desktop.list

sudo apt-get update && sudo apt-get --assume-yes install \
claude-desktop

# Claude Desktop is an Electron app. Its Chromium sandbox needs to create user
# and network namespaces, which the Docker default seccomp profile forbids, so
# the executable aborts before printing anything. The setuid helper at
# /usr/lib/claude-desktop/chrome-sandbox is installed correctly; only the
# container denies it the syscalls. Disable the sandbox to check the version so
# that the test works both on a real desktop and in the container. Running the
# real app needs no such option.
claude-desktop --no-sandbox --version
