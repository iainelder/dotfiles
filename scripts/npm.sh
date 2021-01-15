# https://github.com/sindresorhus/guides/blob/master/npm-global-without-sudo.md
NPM_PACKAGES="${HOME}/.npm-packages"

export PATH="${NPM_PACKAGES}/bin:${PATH}"

export MANPATH="${MANPATH-$(manpath)}:$NPM_PACKAGES/share/man"
