# Set PATH for non-root-installed binaries.
# Do it specially for Github Actions.
# See CVE-2020-15228.
# https://github.com/advisories/GHSA-mfwh-5m23-j46w
if [[ -n "${CI-}" ]]; then
  echo "~/.local/bin" >> "${GITHUB_PATH-}"
else
  PATH=~/.local/bin:"${PATH}"
fi
