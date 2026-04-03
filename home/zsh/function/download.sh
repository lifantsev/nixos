# yt-dlp --preset-alias mp4 --audio-quality 0 -S res:1080 "$(wl-paste)"

function vdl() {
    if [ -n "$1" ]; then
        yt-dlp --preset-alias mp4 "$@"
    else
        yt-dlp --preset-alias mp4 "$(wl-paste)"
    fi
}

function adl() {
    if [ -n "$1" ]; then
        yt-dlp -x --audio-format mp3 --audio-quality 0 "$@"
    else
        yt-dlp -x --audio-format mp3 --audio-quality 0 "$(wl-paste)"
    fi
}
