# qrcopy
png="$(mktemp "/tmp/qrdecode-XXXXX.png")"

slurp -b '#00000060' -s '00000000' -w '0' -F monospace | grim -g - "$png"

data="$(qrtool decode "$png")"

wl-copy "$data"
notify-send "$data"

rm "$png"
