# Useful things that I haven't organized in a better way.

alias hh='history -w /dev/stdout | less'
alias cdtemp='cd $(mktemp --dir ~/tmp/tmp.$(date --iso).XXXXXXXX)'
alias gittree='find -type d -exec sh -c '\''test -d "$1"/.git'\'' -- {} \; -print -prune'

function gut() {
    case $@ in
        "push")
            printf "💩\n"
            ;;

        "status")
            printf "hungry\n"
            ;;

        *)
            command gut "$@"
            ;;
    esac
}

function got() {
    printf "🥤\n"
}

alias prepsquash='git log --reverse --format=format:"* %s%n%b" master..'

function fakeword() {
    gpw 1 8
}

function s3-tree() {
    bucket="$1"
    shift
    tree_params="$@"

    aws s3api list-objects-v2 \
    --bucket "$bucket" \
    --query 'Contents[].[Key]' \
    --output text \
    | tree --fromfile . $tree_params
}

# Converts an ISO timestamp to AWS logs format.
function logtime() {
    iso_timestamp="$1"
    date --date "$iso_timestamp" --utc +%s000
}

function datecalc() {
    ipython --no-confirm-exit -i -c 'from datetime import datetime, timedelta, time'
}

# Pipe to clipboard.
alias copy="xclip -selection c"

# Prepend values to PATH or LDPATH. The seed of a set of path management functions.
# See the "Linux Shell Scripting Cookbook" for an explanation.
# https://subscription.packtpub.com/book/networking-&-servers/9781782162742/1/ch01lvl1sec11/function-to-prepend-to-environment-variables
# I include this mostly as a reminder to read at least one book about Bash.
function prepend() { [ -d "$2" ] && eval $1=\"$2\$\{$1:+':'\$$1\}\" && export $1 ; }

function grepenv() {
    printenv | grep -P "$1"
}

# Most useful for converting IAM policies to CloudFormation.
# Thanks to [Lars Windolf](https://lzone.de/blog/Convert-JSON-to-YAML-in-Linux-bash)
# and [Cooper.Wu](https://stackoverflow.com/a/55171433) for the tips.
function json2yaml {
    python3 -c 'import sys, yaml, json; print(yaml.dump(json.loads(sys.stdin.read()), sort_keys=False))'
}
