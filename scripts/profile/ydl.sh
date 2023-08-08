function ytdl() {
    yt-dlp \
    --verbose \
    --extract-audio \
    --write-info-json \
    --write-all-thumbnails \
    "${1}"
}
