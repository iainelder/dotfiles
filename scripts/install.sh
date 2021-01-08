#!/bin/bash -eux

# Set up bash profile.
cp .bashrc ~/.bashrc
mkdir --parents ~/.dotfiles
cp setpath.sh ~/.dotfiles

# Create user tmp dir
mkdir --parents ~/tmp

export APT_CONFIG=apt.conf

# Curl is used for downloading other things.
sudo apt install curl

# Apart from daily developer use, git may be required for installing various
# things from source. It is a dependency of Homebrew.
sudo apt install git

# Bats is used to self-test later. It's also a useful unit testing tool.
sudo apt install bats

sudo apt install jq

# Install tools for installing other tools that use Python.
sudo apt install \
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

# Install the latest version of Taskcat that actually works
# See https://github.com/aws-quickstart/taskcat/issues/636
pipx install taskcat==0.9.13

pipx install cfn-flip

# Install Docker stuff
sudo apt install docker.io

# Install Ruby stuff
curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-installer | bash

# Install scrcpy.  Use noninteractive to stop badly behaving apt dependencies
# from hanging the unattended process.  This could happen with the tzdata
# package for example (needed for scrcpy).
# See https://github.com/tianon/docker-brew-ubuntu-core/issues/181
sudo DEBIAN_FRONTEND=noninteractive apt --assume-yes install scrcpy

pipx install yamllint

# Install yq
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys CC86BB64
sudo add-apt-repository ppa:rmescandon/yq
sudo apt update
sudo apt install yq -y

echo "All Installed!"
echo "You have to \`source ~/.bashrc\` to make everything work."
