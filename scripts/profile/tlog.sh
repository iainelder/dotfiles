# Record a shell session on demand. tlog-rec logs output only, but an upgrade
# can change that, so check each time rather than once at install.
record() {
  local input
  local path

  # Recording spawns $SHELL, which sources this file again. Refuse to nest.
  if [ -n "${TLOG_RECORDING:-}" ]; then
    echo "Already recording to $TLOG_RECORDING" >&2
    return 1
  fi

  input=$(tlog-rec --configuration 2>/dev/null | jq --raw-output '.log.input' 2>/dev/null)
  case "$input" in
    false) ;;
    true) echo "WARNING: tlog is set to record keystrokes." >&2 ;;
    *) echo "WARNING: unable to confirm whether tlog records keystrokes." >&2 ;;
  esac

  path="${HOME}/.cache/tlog/$(date +%Y%m%dT%H%M%S).log"
  mkdir --parents "${HOME}/.cache/tlog"

  TLOG_RECORDING="$path" tlog-rec --writer=file --file-path="$path"

  echo "Recorded to $path"
  echo "Replay with: tlog-play -r file -i $path"
}
