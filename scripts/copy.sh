ln -sfv "$(realpath .gitconfig)" ~/.gitconfig
ln -sfv "$(realpath .bashrc)" ~/.bashrc
ln -sfv "$(realpath .ackrc)" ~/.ackrc
ln -sfv "$(realpath .vimrc)" ~/.vimrc
rm -rf ~/.dotfiles && ln -sfv "$(realpath profile)" ~/.dotfiles
