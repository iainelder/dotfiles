# Useful things that I haven't organized in a better way.

alias settemp='export tmp=$(mktemp --dir /tmp/bash.XXX)'
alias setroot='r=$(git rev-parse --show-toplevel)'
alias tftree='tree -a -I ".terraform|.terragrunt-cache" --dirsfirst'
alias git-root='cd "$(git rev-parse --show-toplevel)"'
alias hh='history -w /dev/stdout | less'
alias dtree='tree --dirsfirst'
alias cdtmp='cd "$(mktemp --dir)"'
alias gittree='find -type d -exec sh -c '\''test -d "$1"/.git'\'' -- {} \; -print -prune'
