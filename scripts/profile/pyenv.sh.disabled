export PYENV_ROOT="$HOME/.pyenv"
export PATH=":$PATH:$PYENV_ROOT/bin"
eval "$(pyenv init -)"
eval "$(pyenv init --path)"

pyenvlatest() {
    version_prefix="$1"
    pyenv install --list | grep -oP "(?<=  )${version_prefix}.*$" | sort --version-sort | tail -1
}
