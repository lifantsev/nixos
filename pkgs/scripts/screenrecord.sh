if pgrep -x "wf-recorder" > /dev/null; then
    pkill -INT -x wf-recorder
    notify-send "finished recording"
    exit
fi

target="$XDG_VIDEOS_DIR/screenrecord/$(date +'%Y.%m.%d @ %H:%M')"
suffix=""
ext="mkv"

while [ -f "$target$suffix.$ext" ]
do suffix="x$suffix"; done

file="$target$suffix.$ext"

mkdir -p "$(dirname "$file")"
wf-recorder -c libx265 -f "$file" -g "$(slurp -b '#00000060' -s '00000000' -w '0' -F monospace)"
wl-copy < "$file"
