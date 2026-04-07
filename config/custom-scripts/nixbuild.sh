# NOTE THIS ASSUMES USE OF MAKO NOTIF-DAEMON
NOTIF_DAEMON="mako"

source color-helper

function timestamp() { date +'(%H:%M)'; }
function notify() { [ -n "$(pgrep $NOTIF_DAEMON)" ] && notify-send "$1" "$2"; }

while true; do
    printf "$COL_PROMPT"
    echo -n "-> press enter to nixos-rebuild : ";
    [ "$1" == "loop" ] && read -r
    echo "-> $(timestamp)";
    printf "$COL_DEFAULT"

    sudo nixos-rebuild switch --flake path:/home/mark/nixos --show-trace
    result=$?

    if [ $result -eq 0 ]; then
        colorprint "$COL_SUCCESS" "-> successful build $(timestamp)\n"
        notify "nix rebuild succeeded"
    else
        colorprint "$COL_FAIL" "-> build failed $(timestamp)\n"
        notify "ERROR IN NIX REBUILD"
    fi

    [ "$1" == "loop" ] && echo || exit $result
done
