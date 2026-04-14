# NOTE this script assumes we are using mako

action="$1"
[ -n "${2:-}" ] && ms="$2" || ms=3000

title=""
body=""
warning=""

case "$action" in
    volume*)
        title="vol: $(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{ printf $2*100; printf "%"; if ($3 == "[MUTED]") print " (muted)"; else print "";  }')"
        ;;
    brightness*)
        title="brightness: $(bc <<< "100 * $(brightnessctl get) / $(brightnessctl max)")%"
        ;;
    date*)
        title="$(date +'%b %-d %Y')"
        ;;
    time*)
        title="$(date +'%H:%M')"

        hour="$(date +'%H')"

        [ 22 -le "$hour" ] && warning="hey it's time to go to bed"
        [ "$hour" -lt 5 ] && warning="please fucking go to sleep"
        ;;
    battery*)
        percentage="$(upower -b | awk '/ percentage: / { print $2 }')"
        # the awk logic just cuts time xx.x -> xx, leaves x.x alone
        time="$(upower -b | awk '/ time to / { if (length($4) == 4) { printf substr($4, 1, 2); } else { printf $4; }; print substr($5, 1, 1) }')"
        state="$(upower -b | awk '/ state: / { if ($2 == "charging") { print "+" } else if ($2 == "discharging") { print "-" } else { print "DONT CHARGE TO 100!" }}')"

        title="battery: $percentage ($state$time)"

        [ "$state" == "-" ] && [ "${percentage//%/}" -le 30 ] && warning="warning: please charge"
        [ "$state" == "+" ] && [ "${percentage//%/}" -ge 80 ] && warning="warning: please disconnect"
        ;;
    music*)
        song="$(plyr current)"
        song="$(echo "$song" | rustranslit)"
        song="$(echo "$song" | iconv -f utf8 -t ascii//TRANSLIT//IGNORE | LC_COLLATE=C sed -e "s/[^ 0-9a-zA-Z':().,-]//g")"

        # removes trailing whitespace
        # removes leading whitespace
        # any trailing [] square brackets
        # removes any trailing () parens
        # changes feat. to ft.
        # compresses all whitespace to single spaces
        song="$(echo "$song" | sed \
            -e 's|\s*$||' \
            -e 's|^\s*||' \
            -e 's|\[.*\]\s*$||' \
            -e 's|\s*(.*)$||' \
            -e 's|feat\.|ft\.|' \
            -e 's|\s\+| |g'
        )"

        song="$(echo "$song" | tr '[:upper:]' '[:lower:]')"

        title="$song"
        [[ "$action" != *"short" ]] && [ "$(plyr client)" == "spotify" ] && body="$(plyr indicator)$(plyr progress)%"
        ;;
esac

[[ "$action" == *"warn" ]] && [ -z "$warning" ] && exit # only warn when theres a warning

makoctl dismiss -a # NOTE requires us to be using mako
notify-send -t "$ms" "$title" "$body$warning"
