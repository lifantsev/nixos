# TODO add more features

# nixos-rebuild ... --override-input nvim /path/to/nixvim
# nix flake update "spec"

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
        printmsg "successful build $(timestamp)"
        notify "nix rebuild succeeded"
    else
        printmsg "failed to build $(timestamp)"
        notify "ERROR IN NIX REBUILD"
    fi

    [ "$1" == "loop" ] && echo || exit $result
done
