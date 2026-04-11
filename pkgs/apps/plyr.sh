# script that unifies some media controller interfaces:
# - mpc
# - spotify_player
# - mpvc
# - playerctl
# supports pause/play, skip, get current song etc

function mpc_playing() { mpc 2>/dev/null | sed -n 2p | grep -q '\[playing\]'; }
function spotify_playing() { spotify_player get key playback 2>/dev/null | jq .is_playing | grep -q true; }
function mpv_playing() { mpvc status 2>/dev/null | sed -n 2p | grep -q '^\[play\] '; }
function playerctl_playing() { playerctl status 2>/dev/null | grep -q '^Playing$'; }

#########
# SETUP #
#########
cmd="$1"
arg="$2"
current=""
current_default="spotify"
file="/tmp/plyr.current"
[ -f "$file" ] || echo "$current_default" > "$file"

#######################
# FIND CURRENT PLAYER #
#######################
playerctl_playing && current='playerctl'
mpc_playing && current='mpc'
mpv_playing && current='mpv'
spotify_playing && current='spotify'

if [ -z "$current" ]; then
    current="$(cat "$file")"
fi

# if our current is mpv but the mpv has now been closed
# we will not be able to return a lot of data correctly
# so we reset current player
if [ "$current" == "mpv" ]; then
    mpvc status | head -n 1 | grep -q '^.mpvc-wrapped: Error: No files added' && current="$current_default"
fi

echo "$current" > "$file"

###################
# EXECUTE COMMAND #
###################
case "$cmd" in
    "set"): # just set the current player (alias for no arg)
        ;;
    "toggle"): # play / pause
        case "$current" in
            "mpc") mpc toggle >> /dev/null;;
            "spotify") spotify_player playback play-pause >> /dev/null;;
            "mpv") mpvc toggle >> /dev/null;;
            "playerctl") playerctl play-pause;;
        esac
        ;;
    "play"):
        [ "$(plyr playing)" = "false" ] && plyr toggle ;;
    "pause"):
        [ "$(plyr playing)" = "true" ] && plyr toggle ;;
    "prev"):
        case "$current" in
            "mpc") mpc prev;;
            "spotify") spotify_player playback previous && spotify_player playback previous &>/dev/null;;
            "mpv") mpvc prev;;
            "playerctl") playerctl previous;;
        esac
        ;;
    "next"):
        case "$current" in
            "mpc") mpc next;;
            "spotify") spotify_player playback next &>/dev/null;;
            "mpv") mpvc next;;
            "playerctl") playerctl next;;
        esac
        ;;
    "seek"):
        case "$current" in
            "mpc") mpc seek "$arg";;
            "spotify") spotify_player seek "$arg" &>/dev/null;;
            "mpv") mpvc seek "$arg";;
            "playerctl") playerctl position "$arg";;
        esac
        ;;
    "playing"):
        case "$current" in
            "mpc")       mpc_playing && echo true || echo false ;;
            "spotify")   spotify_playing && echo true || echo false ;;
            "mpv")       mpv_playing && echo true || echo false;;
            "playerctl") playerctl_playing && echo true || echo false;;
        esac
        ;;
    "current"):
        name="na"

        case "$current" in
            "mpc")
                if [ "$(mpc status | wc -l)" != 1 ]; then
                    name="$(mpc status | head -n 1 | sed 's|\.[^.]*$||')"
                fi
                ;;
            "spotify") name="$(spotify_player get key playback | jq -r '"\(.item.artists[0].name) - \(.item.name)"')" ;;
            "mpv") name="$(mpvc status | head -n 1 | sed 's|^NA - ||')" ;;
            "playerctl") name="$(playerctl metadata title)" ;;
        esac

        echo "$name"
        ;;
    "progress")
        case "$current" in
            "mpc") mpc status | sed -n 2p | sed -e 's|.*(||' -e 's|%)$||' ;;
            "spotify") spotify_player get key playback | jq '(100 * .progress_ms / .item.duration_ms) | round' ;;
            "mpv") mpvc status | sed -n 2p | grep -o '([0-9]\+%)$' | grep -o '[0-9]\+' ;;
            "playerctl") echo "100000000 * $(playerctl position) / $(playerctl metadata mpris:length)" | bc ;;
        esac
        ;;
    "indicator"):
        indicator=""
        case "$current" in
            "mpc")
                mpc status | tail -n 1 | grep -q 'single: on' && indicator+="loop "
                mpc status | tail -n 1 | grep -q 'random: off' && indicator+="shuffle "
                ;;
            "spotify") 
                spotify_player get key playback | jq .shuffle_state | grep -q true && indicator+="shuf "
                spotify_player get key playback | jq -r .repeat_state | grep -q track && indicator+="loop "
                spotify_player get key playback | jq -r .repeat_state | grep -q off && indicator+="noloop "
                ;;
            "mpv") ;;
            "playerctl") ;;
        esac

        echo "$indicator" # NOTE this includes the trailing space
        ;;
    "client"):
        echo "$current"
        ;;
esac
