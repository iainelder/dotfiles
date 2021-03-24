# Set up bash profile.
ln -sfv "$(realpath .bashrc)" ~/.bashrc
ln -sfv "$(realpath .ackrc)" ~/.ackrc
rm -rf ~/.dotfiles && ln -sfv "$(realpath profile)" ~/.dotfiles
