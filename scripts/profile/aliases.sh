# Useful things that I haven't organized in a better way.

alias settemp='export tmp=$(mktemp --dir /tmp/bash.XXX)'
alias setroot='r=$(git rev-parse --show-toplevel)'
alias tftree='tree -a -I ".git|.terraform|.terragrunt-cache" --dirsfirst'
alias git-root='cd "$(git rev-parse --show-toplevel)"'
alias hh='history -w /dev/stdout | less'
alias dtree='tree --dirsfirst -a'
alias cdtemp='cd $(mktemp --dir ~/tmp/tmp.$(date --iso).XXXXXXXX)'
alias gittree='find -type d -exec sh -c '\''test -d "$1"/.git'\'' -- {} \; -print -prune'


# Discovered on Unix and Linux stack exchange.
# https://unix.stackexchange.com/a/691245/48038
# --files : Print files that would be searched
# --hidden : Print files starting with '.'
# --ignore : Respect .gitignore
# --glob '!.git/' : ignore .git/ directory
gtree() {
    rg --files --hidden --ignore --glob '!.git/' "$@" \
    | tree --fromfile -a
}


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

function got() {
    printf "🥤\n"
}

alias query='sqlite3 --readonly --csv --header'

alias prepsquash='git log --reverse --format=format:"* %s%n%b" master..'

function fakeword() {
    gpw 1 8
}
