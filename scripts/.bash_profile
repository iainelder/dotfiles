# Allows Github Actions to source .bashrc when running as non-interactive login shell.
# It's not possible to start an interactive shell in Github Actions.
# Desktop Ubuntu doesn't need this file because every terminal is an interactive shell.
# But it has no adverse side effects that I'm aware of.
if [[ -f ~/.bashrc ]]; then
  source ~/.bashrc
end

