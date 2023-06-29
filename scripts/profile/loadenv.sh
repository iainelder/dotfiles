# Maintains a global register of env locations.
# Starts a Bash session that uses the environment in any working directory.
# Inspired by direnv and bashmarks.

if [ ! -n "$ENVDIR" ]; then
    ENVDIR="${HOME}/.config/envsets"
fi
mkdir --parents "$ENVDIR"

function .env {
    declare name="${1}"

    ! [ -L "$ENVDIR/$name" ] && {
        echo "$name is not an env"
        return 1
    }

    envdir="$(dirname "$(realpath "$ENVDIR/$name")")"

    # Start a subshell as the simplest way to unload variables at the end.
    # `init-file` runs commands before going interactive.
    #
    # 1. Load bashrc because `init-file` overrides the normal load sequence.
    # 2. Add env name to shell prompt as Python's virtualenv does.
    # 3. Move into the envdir so that commands like `pwd` work in the .envrc
    # 4. Load direnv stdlib because env files may use it.
    # 5. Load the .envrc without using direnv to use it in any directory.
    # 6. Move back so that when Bash goes interactive I'm in the same place.
    #
    # 
    bash --init-file <(
        cat \
            ~/.bashrc \
            <(cat <<< "export PS1='($name) $PS1'") \
            <(cat <<< "pushd '$envdir' > /dev/null") \
            <(direnv stdlib) \
            "$ENVDIR/$name" \
            <(cat <<< "popd > /dev/null") \
    )
}

# Register a new env or update an existing one. Prompts to confirm update.
function lnenv {
    declare name="${1}"
    declare path="${2}"

    ln -s -i -T "$path" "$ENVDIR/$name"
}

# Unregister an env.
function rmenv {
    declare name="${1}"

    rm "$ENVDIR/$name"
}

# Lists registered env files.
function lsenv {
    find "$ENVDIR" -mindepth 1 -maxdepth 1 -printf "%f -> %l\n"
}

# I discovered similar tools after writing this. The magic words to search on
# Google for were `bash environment switcher`.

# https://github.com/smarie/env-switcher-gui
# https://github.com/robdmc/switchenv
