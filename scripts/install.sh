#!/bin/bash -eux

# Set up bash profile.
cp .bashrc ~/.bashrc

# Create user tmp dir
mkdir --parents ~/tmp

# Curl is used for downloading other things.
sudo apt --assume-yes install curl

# Apart from daily developer use, git may be required for installing various
# things from source.
sudo apt --assume-yes install git

# Bats is used to self-test later. It's also a useful unit testing tool.
sudo apt --assume-yes install bats

sudo apt --assume-yes install jq

# Install tools for installing other tools that use Python.
sudo apt --assume-yes install \
	python3-pip \
	python3-venv
pip3 install --user pipx

# Hack the path in here temporarily for pipx. This is fixed permanently when
# .bashrc is sourced.
# FIXME not sure if this is what makes the bats test work or not...
PATH=~/.local/bin:$PATH

echo DEBUG $PATH

# Install csvkit, the king of CSV analyzers.
pipx install csvkit

# Test that everything worked with bats
bats ../test.bats

echo "All Installed!"
echo "You have to \`source ~/.bashrc\` to make everything work."
