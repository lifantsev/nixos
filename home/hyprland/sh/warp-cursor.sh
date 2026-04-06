#!/usr/bin/env bash

# make sure we are the only one running
kill $(pgrep -f "bash /home/mark/.config/hypr/sh/warp-cursor.sh" | grep -v $$)

socat -u "unix-connect:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" stdout |
    while read -r line; do
        case $line in
            # move cursor to center of opened window
            "openwindow>>"*)
                ID=${line#openwindow>>}
                ID=${ID%%,*}
                hyprctl dispatch movecursor "$(
                    hyprctl -j clients |
                        jq -r 'map(select(.address=="0x'"$ID"'")).[0] | "\(.at[0] + (.size[0]/2 | rint)) \(.at[1] + (.size[1]/2 | rint))"'
                )" >/dev/null
            ;;
            # move cursor to active window on ws change
            "workspace>>"*)
                hyprctl dispatch movecursor "$(
                    hyprctl -j activewindow | jq -r '"\(.at[0] + (.size[0]/2 | rint)) \(.at[1] + (.size[1]/2 | rint))"'
                )" >/dev/null
            ;;
        esac
    done
