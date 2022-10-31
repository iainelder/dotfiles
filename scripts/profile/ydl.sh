function ytdl() {
    youtube-dl \
    --verbose \
    --extract-audio \
    --write-info-json \
    --write-all-thumbnails \
    "${1}"
}
