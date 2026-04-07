# blue.sh
# a small script to interact with bluetoothctl using device names instead of adresses

source color-helper

function print_help() {
    echo "'blue' allows you to interact with bluetoothctl using device names instead of blueooth addresses"
    echo
    echo "h|help            : prints this help menu"
    echo "u|connect <name?> : connect to either specified device or default device"
    echo "d|disconnect      : disconnect from current device"
    echo "r|reload          : reload the connection to current device"
    echo "p|pair <str>      : search for a device with <str> in its name and pair with it"
    echo "drop              : open a bluetoothctl subshell"
}

# TRIVIAL HELPERS
function name_to_address() { bluetoothctl devices Paired | awk "/ $1[^ ]*\$/ { print \$2 }" ;}
function is_address() { echo "$1" | grep -q '^\([0-9A-F]\{2\}:\)\{5\}[0-9A-F]\{2\}$' ;}
function make_address() { is_address "$1" && echo "$1" || name_to_address "$1"; }
function current() { bluetoothctl devices Connected | awk 'NR==1 { print $2 }'; }
function default() { bluetoothctl devices Paired | awk 'NR==1 { print $2 }'; }
function address_to_name() { bluetoothctl devices | awk "/ $1 / { print \$3 }" ;}
function address_to_desc() { echo "$(address_to_name "$1") ($1)" ;}

function printmsg() {
    if [[ "$1" == "fail"* ]]; then
        colorprint "$COL_FAIL" "-> $1\n"
        return 1
    elif [[ "$1" == "info"* ]]; then
        colorprint "$COL_INFO" "-> $1\n"
    else
        colorprint "$COL_SUCCESS" "-> $1\n"
    fi

    return 0
}

# NONTRIVIAL HELPERS
function connect_address() {
    if bluetoothctl connect "$1";
    then printmsg "successfully connected to $(address_to_desc "$1")"
    else printmsg "failed to connect to $(address_to_desc "$1")"
    fi
}

function disconnect() {
    if bluetoothctl disconnect;
    then printmsg "successfully disconnected"
    else printmsg "failed to disconnect"
    fi
}

function reload() {
    current="$(current)"
    [ -z "$current" ] && echo "cannot reload: not currently connected to anything" && return 1

    playing="$(plyr playing)"

    if disconnect && connect_address "$current"; then
        [ "$playing" == "true" ] && plyr play
        printmsg "succesfully reloaded $(address_to_name "$current")"
    else
        printmsg "failed to reload $(address_to_name "$current")"
    fi
}

function pair() {
    result=""
    bluetoothctl --timeout 10 scan on > /dev/null &
    starttime="$(date +%s)"
    while true ; do
        result="$(bluetoothctl devices | grep -i "$1")"
        [ -n "$result" ] && break

        if [ "$(bc <<< "$(date +%s) - $starttime")" -gt 15 ]
        then printmsg "failed to find a match by scan timeout" ; return 1; fi
    done
    bluetoothctl scan off > /dev/null

    sleep 0.5
    if [ "$(echo "$result" | wc -l)" -gt 1 ]
    then choice="$(echo "$result" | fzf)" 
    else choice="$(echo "$result" | head -n 1)" ; printmsg "info: found a match: $choice"
    fi
    if [ -z "$choice" ]; then printmsg "failed to select device" ; return 1; fi

    address="$(echo "$choice" | sed 's| |\n|g' | grep "[0-9A-F]\{2\}:[0-9A-F]\{2\}:[0-9A-F]\{2\}:[0-9A-F]\{2\}:[0-9A-F]\{2\}:[0-9A-F]\{2\}")"
    if [ -z "$address" ]; then printmsg "failed to recover address" ; return 1; fi

    if bluetoothctl pair "$address" > /dev/null
    then printmsg "successfully paired"
    else printmsg "failed to pair $1" && return 1
    fi

    if bluetoothctl trust "$address"
    then printmsg "successfully trusted"
    else printmsg "failed to trust $1"
    fi
}

# MAIN FUNCTIONALITY
function handle_command() {
    case "$1" in
        "u"|"connect") 
            if [ -z "$2" ]
            then connect_address "$(default)"
            else connect_address "$(make_address "$2")"; fi
            ;;
        "d"|"disconnect") bluetoothctl disconnect;;
        "r"|"reload") reload;;
        "p"|"pair") pair "$2";;
        "h"|"help") print_help;;
        "drop") bluetoothctl;;
    esac
}

if [ -n "$1" ]; then
    handle_command "$1" "$2"
    exit
fi

while true; do
    curname="$(address_to_name "$(current)")"
    [ -n "$curname" ] && curname+=": "

    printf "$COL_PROMPT-> $curname"
    read -r response
    printf "$COL_DEFAULT"

    if [[ "$response" == *" "* ]]
    then handle_command "${response%% *}" "${response#* }"
    else handle_command "$response"
    fi
    echo
done
