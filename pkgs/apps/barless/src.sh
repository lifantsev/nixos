# NOTE this script assumes we are using mako

action="$1"
[ -n "${2:-}" ] && ms="$2" || ms=3000

title=""
body=""
warning=""
category=""

if [ "$action" == "--daemon" ]; then
    # kill other daemons
    my_pid="$$"
    other_pids="$(pgrep barless)" # avoid opening a pipe b/c it would create a new process
    other_pids="$(echo "$other_pids" | grep -v "$my_pid")"
    [ -n "$other_pids" ] && kill $other_pids # don't quote to handle multiple pids

    while true; do
        "$0" time-warn
        sleep 30
        "$0" battery-warn
        sleep 30
    done

    exit
fi

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
        percentage="$(upower -b | awk '/ percentage: / { print $2 }' | sed 's|\.[0-9]*%|%|')"
        # the awk logic just cuts time xx.x -> xx, leaves x.x alone
        time="$(upower -b | awk '/ time to / { if (length($4) == 4) { printf substr($4, 1, 2); } else { printf $4; }; print substr($5, 1, 1) }')"
        state="$(upower -b | awk '/ state: / { if ($2 == "charging") { print "+" } else if ($2 == "discharging") { print "-" } else { print "" }}')"

        title="battery: $percentage ($state$time)"

        [ "$state" == "-" ] && [ "${percentage//%/}" -le 20 ] && warning="warning: please charge"
        [ "$state" == "+" ] && [ "${percentage//%/}" -ge 80 ] && warning="warning: please disconnect"
        ;;
    music*)
        current="$(plyr current)"

        function process_str() {
            out="$(echo "$1" | rustranslit | iconv -f utf8 -t ascii//TRANSLIT//IGNORE | LC_COLLATE=C sed -e "s/[^ 0-9a-zA-Z':().,-]//g")"

            # removes trailing whitespace
            # removes leading whitespace
            # any trailing [] square brackets
            # removes any trailing () parens
            # changes feat. to ft.
            # compresses all whitespace to single spaces
            out="$(echo "$out" | sed \
                -e 's|\s*$||' \
                -e 's|^\s*||' \
                -e 's|\[.*\]\s*$||' \
                -e 's|\s*(.*)$||' \
                -e 's|feat\.|ft\.|' \
                -e 's|\s\+| |g'
            )"

            echo "$out" | tr '[:upper:]' '[:lower:]'
        }

        song_artist="$(process_str "${current%% - *}")"
        song_artist="${song_artist//, / \& }"
        song_title="$(process_str "${current#* - }")"

        title="$song_artist"
        body="$song_title"

        # song_progress="$(plyr progress)"
        # [ -n "$song_progress" ] && body+=" ($song_progress%)"
        ;;
    calendar*)
        title="$(cal | head -n 1)"
        body="$(cal | tail -n +2)"
        ;;
esac

[[ "$action" == *"warn" ]] && [ -z "$warning" ] && exit # only warn when theres a warning

makoctl dismiss -a # NOTE requires us to be using mako
notify-send -c "$action" -t "$ms" "$title" "$body$warning"
