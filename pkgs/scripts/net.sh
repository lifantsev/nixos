# net.sh
# a script to easily interact with nmcli

# TODO pass --ask to nmcli

# TODO prevent waiting long times for network list lookup
# by first only looking thru saved networks

# TODO add a command that runs `systemctl restart NetworkManager`

source color-helper

function print_help() {
    echo "'net' lets you interact with nmcli efficiently through a text-based interface"
    echo
    echo "u|connect <str> : connects to the first network whose name starts with or contains <str>"
    echo "d|disconnect    : disconnects from the current network"
    echo "m|menu          : allows you to select a network from a menu & connects to it"
    echo "r|reload        : reloads the current connection"
    echo "c|credentials   : shows the credentials to the current network"
    echo "p|ping          : pings google"
    echo "h|help          : prints this help menu"
}

# TRIVIAl
function current() { nmcli -t connection show --active | grep -v 'loopback' | head -n 1 | awk -F : '{ print $1 }' ;}
function list() { nmcli -t device wifi list | grep -v '::' | awk -F ':' '{ print $8 }' | sort | uniq ;}
function complete_id() {
    result="$(list | grep -i "^$id" | head -n 1)"

    [ -z "$result" ] && result="$(list | grep -i "$id" | head -n 1)"

    if [ -z "$result" ]
    then printmsg "failed to find a match to $id"
    else id="$result"
    fi
}

# NONTRIVIAL HELPERS
function connect_id() {
    if nmcli device wifi connect "$id"
    then printmsg "successfully connected to $id"
    else printmsg "failed to connect to '$id'"
    fi
}

function disconnect() {
    if nmcli connection down "$(current)"
    then printmsg "successfully disconnected"
    else printmsg "failed to disconnect"
    fi
}

function reload() {
    current="$(current)"
    if [ -z "$current" ]
    then printmsg "failed to reload: no current connection" ; return 1
    fi

    if disconnect && connect_id "$current";
    then printmsg "succesfully reloaded $current"
    else printmsg "failed to reload '$current'"
    fi
}

function credentials() {
    echo -n "show credentials to current network? (y/n)" && read -r -n 1 key
    echo
    [ "$key" == "y" ] && nmcli device wifi show-password
}

# MAIN FUNCTIONALITY
function handle_command() {
    case "$1" in
        "u"|"connect") id="$2"; complete_id && connect_id ;;
        "d"|"disconnect") disconnect ;;
        "m"|"menu") id="$(list | fzf)" ; connect_id ;;
        "r"|"reload") reload ;;
        "c"|"credentials") credentials ;;
        "p"|"ping") ping google.com ;;
        "v"|"vpn") vpn "$2" "$3" ;;
        "h"|"help") print_help ;;
    esac
}

if [ -n "$1" ]; then
    handle_command "$1" "$2"
    exit
fi

while true; do
    curname="$(vpn isup && echo "v ")$(current | tr '[:upper:]' '[:lower:]')"
    [ -n "$curname" ] && curname+=": "

    colorprint "$COL_PROMPT" "-> $curname"
    read -r response

    if [[ "$response" == *" "* ]]
    then handle_command "${response%% *}" "${response#* }"
    else handle_command "$response"
    fi
    echo
done
