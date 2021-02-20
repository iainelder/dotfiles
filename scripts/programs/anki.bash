# https://apps.ankiweb.net/
# https://github.com/ankitects/anki/releases
# https://gist.github.com/lukechilds/a83e1d7127b78fef38c2914c4ececc3c#gistcomment-2574561

set -euxo pipefail

cd "$(mktemp)"

browser_download_url=$(
  curl -Ss 'https://api.github.com/repos/ankitects/anki/releases/latest' |
  jq -r '.assets[] | select(.name | test("linux")) | .browser_download_url'
)

download_filename=$(
  curl \
  --silent \
  --show-error \
  --url "$browser_download_url" \
  --location \
  --remote-name \
  --write-out '%{filename_effective}'
)

tar --extract --bzip2 --file "$download_filename"

extract_folder=$(basename "$download_filename" ".tar.bz2")

cd "$extract_folder"

sudo ./install.sh
