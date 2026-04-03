# NOTE THIS ASSUMES USE OF MAKO NOTIF-DAEMON
NOTIF_DAEMON="mako"

# https://gist.github.com/vratiu/9780109
COL_DEFAULT="\033[0m"
COL_PROMPT="\033[0;34m"
COL_FAIL="\033[0;31m"
COL_SUCCESS="\033[0;32m"

function timestamp() { date +'(%H:%M)'; }
function colorprint() { printf "$1$2$COL_DEFAULT"; }
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
        notify "nix rebuild" "success"
    else
        colorprint "$COL_FAIL" "-> build failed $(timestamp)\n"
        notify "nix rebuild" "BUILD FAILED"
    fi

    [ "$1" == "loop" ] && echo || exit $result
done
