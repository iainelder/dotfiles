#!/bin/bash -eu

cp .bashrc ~/.bashrc

mkdir --parents ~/tmp

sudo apt --assume-yes install \
	python3-pip \
	python3-venv
pip3 install --user pipx

pipx install csvkit

echo "All Installed!"
echo "You have to \`source ~/.bashrc\` to make everything work."
