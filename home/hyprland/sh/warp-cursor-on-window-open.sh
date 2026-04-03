#!/usr/bin/env bash

# TODO use this for a while and consider also focusing window on window close
# TODO move mouse to focused window on workspace change

socat -u "unix-connect:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" stdout |
    while read -r line; do
        case $line in
            "openwindow>>"*)
                ID=${line#openwindow>>}
                ID=${ID%%,*}
                hyprctl dispatch movecursor "$(
                    hyprctl -j clients |
                        jq -r '
                    map(select(.address=="0x'"$ID"'")).[0] |
                        "\(.at[0] + (.size[0]/2 | rint)) \(.at[1] + (.size[1]/2 | rint))"
                    '
                    )" >/dev/null
                    ;;
            esac
        done
