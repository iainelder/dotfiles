# Maintains a global register of direnv locations.
# Starts a Bash session that uses the environment in any working directory.
# Inspired by direnv and bashmarks.

if [ ! -n "$ENVDIR" ]; then
    ENVDIR="${HOME}/.config/envsets"
fi
mkdir --parents "$ENVDIR"

function .env {
    declare name="${1}"

    bash --init-file <(cat \
        ~/.bashrc \
        <(direnv stdlib) \
        "$ENVDIR/$name" \
        <(cat <<< "export PS1='($name) $PS1'") \
    )
}

function lnenv {
    declare name="${1}"

    ln -s -i -T "$(pwd)/.envrc" "$ENVDIR/$name"
}

function rmenv {
    declare name="${1}"

    rm "$ENVDIR/$name"
}

function lsenv {
    find "$ENVDIR" -mindepth 1 -maxdepth 1 -printf "%f -> %l\n"
}
