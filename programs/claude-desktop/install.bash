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

# --no-sandbox: Electron's Chromium sandbox uses clone(CLONE_NEWUSER) syscall.
# Docker's seccomp profile blocks it.
claude-desktop --no-sandbox --version
