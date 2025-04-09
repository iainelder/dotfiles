ln -sfv "$(realpath .gitconfig)" ~/.gitconfig
ln -sfv "$(realpath .bashrc)" ~/.bashrc
ln -sfv "$(realpath .ackrc)" ~/.ackrc
ln -sfv "$(realpath .vimrc)" ~/.vimrc
ln -sfv "$(realpath .dircolors)" ~/.dircolors
ln -sfv "$(realpath .inputrc)" ~/.inputrc
ln -sfv "$(realpath .direnvrc)" ~/.direnvrc
rm -rf ~/.dotfiles && ln -sfv "$(realpath profile)" ~/.dotfiles
