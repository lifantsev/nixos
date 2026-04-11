target="$XDG_PICTURES_DIR/screenshot/$(date +'%Y.%m.%d @ %H:%M')"
suffix=""
ext="png"

while [ -f "$target$suffix.$ext" ]
do suffix="x$suffix"; done

file="$target$suffix.$ext"

mkdir -p "$(dirname "$file")"
slurp -b '#00000060' -s '00000000' -w '0' -F monospace | grim -g - "$file"
wl-copy < "$file"
