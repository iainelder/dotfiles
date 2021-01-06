#!/bin/bash -eux

# Set up bash profile.
cp .bashrc ~/.bashrc
mkdir --parents ~/.dotfiles
cp setpath.sh ~/.dotfiles

# Create user tmp dir
mkdir --parents ~/tmp

# Curl is used for downloading other things.
sudo apt --assume-yes install curl

# Apart from daily developer use, git may be required for installing various
# things from source. It is a dependency of Homebrew.
sudo apt --assume-yes install git

# Bats is used to self-test later. It's also a useful unit testing tool.
sudo apt --assume-yes install bats

sudo apt --assume-yes install jq

# Install tools for installing other tools that use Python.
sudo apt --assume-yes install \
	python3-pip \
	python3-venv
pip3 install --user pipx

# After the bootstrap process, this path will be added automatically by
# sourcing bashrc. Right now we need to do it here to call pipx.
PATH=~/.local/bin:$PATH

# Install csvkit, the king of CSV analyzers.
pipx install csvkit

# Install JumpCloud CLI.
pipx install git+https://github.com/Sage-Bionetworks/jccli

# Install aws-cli
for f in programs/*.sh; do
  echo "Running $f"
  "$f"
done

# Install AWS SAM CLI.
pipx install aws-sam-cli

# Install AWS CloudFormation Linter
pipx install cfn-lint

pipx install taskcat

echo "All Installed!"
echo "You have to \`source ~/.bashrc\` to make everything work."
