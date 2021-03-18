# Set up bash profile.
ln -sfv "$(realpath .bashrc)" ~/.bashrc
rm -rf ~/.dotfiles && ln -sfv "$(realpath profile)" ~/.dotfiles
