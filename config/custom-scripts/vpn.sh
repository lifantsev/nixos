# net.sh
# a script to easily interact with nmcli

WGPATH="/etc/wireguard"

source color-helper

function print_help() {
    echo "'vpn' helps you manage vpn connections with wireguard"
    echo
    echo "u|connect <str> : connects to the first vpn whose name starts with or contains <str>"
    echo "d|disconnect    : disconnects from the current vpn"
    echo "m|menu          : allows you to select a vpn from a menu & connects to it"
    echo "r|reload        : reloads the current connection"
    echo "c|current       : prints the name of current vpn"
    echo "h|help          : prints this help menu"
}

# TRIVIAL HELPERS
function list() { ls $WGPATH | sed 's|\.conf$||' ;}
function current() { sudo wg show | grep '^interface:' | head -n 1 | sed 's|^interface: ||' ;}
function complete_name() {
    result="$(list | grep -i "^$name" | head -n 1)"
    [ -z "$result" ] && result="$(list | grep -i "$id" | head -n 1)"

    if [ -z "$result" ]
    then printmsg "failed to find a match to $id"
    else name="$result"
    fi
}

# NONTRIVIAL HELPERS
# NOTE these require root access
function connect_name() {
    if wg-quick up "$name"
    then printmsg "succesfully connected to $name"
    else printmsg "failed to connect to $name"
    fi
}

function disconnect() {
    if wg-quick down "$(current)"
    then printmsg "successfully disconnected"
    else printmsg "failed to disconnect"
    fi
}

function reload() {
    current="$(current)"
    if [ -z "$current" ]
    then printmsg "failed to reload: no current connection" ; return 1
    fi

    if disconnect && connect_name "$current";
    then printmsg "succesfully reloaded $current"
    else printmsg "failed to reload '$current'"
    fi
}

# MAIN FUNCTIONALITY
function handle_command() {
    case "$1" in
        "u"|"connect") name="$2"; complete_name && connect_name ;;
        "d"|"disconnect") disconnect ;;
        "m"|"menu") name="$(list | fzf)" ; connect_name ;;
        "r"|"reload") reload ;;
        "c"|"current") current ;;
        "h"|"help") print_help ;;
    esac
}

if [ -n "$1" ]; then
    handle_command "$1" "$2"
    exit
fi

while true; do
    curname="$(current | tr '[:upper:]' '[:lower:]')"
    [ -n "$curname" ] && curname+=": "

    colorprint "$COL_PROMPT" "-> $curname"
    read -r response

    if [[ "$response" == *" "* ]]
    then handle_command "${response%% *}" "${response#* }"
    else handle_command "$response"
    fi
    echo
done
