# Useful things that I haven't organized in a better way.

alias settemp='export tmp=$(mktemp --dir /tmp/bash.XXX)'
alias setroot='r=$(git rev-parse --show-toplevel)'
alias tftree='tree -a -I ".git|.terraform|.terragrunt-cache" --dirsfirst'
alias git-root='cd "$(git rev-parse --show-toplevel)"'
alias hh='history -w /dev/stdout | less'
alias dtree='tree --dirsfirst -a'
alias cdtemp='cd $(mktemp --dir ~/tmp/tmp.$(date --iso).XXXXXXXX)'
alias gittree='find -type d -exec sh -c '\''test -d "$1"/.git'\'' -- {} \; -print -prune'
alias pytree='tree -a -I ".git|__pycache__|.mypy_cache|.pytest_cache|.venv" --dirsfirst'

function gut() {
    case $@ in
        "push")
            printf "💩\n"
            ;;

        "status")
            printf "hungry\n"
            ;;

        *)
            command gut $@
            ;;
    esac
}

alias query='sqlite3 --readonly --csv --header'
