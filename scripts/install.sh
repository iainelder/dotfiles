cp .bashrc ~/.bashrc

mkdir --parents ~/tmp

sudo apt --assume-yes install python3-pip
pip3 install --user pipx

echo "All Installed!"
echo "You have to \`source ~/.bashrc\` to make everything work."
