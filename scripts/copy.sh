ln -sfv "$(realpath .gitconfig)" ~/.gitconfig
ln -sfv "$(realpath .bashrc)" ~/.bashrc
ln -sfv "$(realpath .ackrc)" ~/.ackrc
rm -rf ~/.dotfiles && ln -sfv "$(realpath profile)" ~/.dotfiles
