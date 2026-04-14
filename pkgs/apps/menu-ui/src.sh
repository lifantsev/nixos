# menu-ui/src.sh

export LGSTEM=menu
export LGSPEC=ui

lg start

fifo_path=$XDG_STATE_HOME/menu/default.fifo

if [ -n "${1:-}" ]; then
    lg . "processing argument[$1]"

    case "$1" in
        "--getfifo") echo "$fifo_path"; ;;
        *) lg E "unrecognized argument[$1]" ; exit 1 ;;
    esac

    lg finish
    exit 0
fi

if [ -e "$fifo_path" ]; then
    lg I "removing existing fifo: $fifo_path"
    rm "$fifo_path" &> /dev/null || :
fi

lg I "initializing fifo: $fifo_path"
mkdir -p "$(dirname "$fifo_path")"
mkfifo "$fifo_path"

# NOTE these functions assume hyprland + pyprland
function ui_is_hidden() {
    if [ -z "${HYPRLAND_INSTANCE_SIGNATURE:-}" ]; then
        lg E "HYPRLAND_INSTANCE_SIGNATURE is not set! this is needed by hyprctl to work properly"
        exit 1
    fi

    lg . "checking if ui_is_hidden using hyprctl"
    hyprctl clients -j |
        jq -r 'first(.[] | select(.class == "scratchpad" and .title == "menu-ui") | .workspace.name)' |
        grep -q '^special'
}

function show_ui() {
    lg . "running drop menui-ui --nohist"
    if ! output="$(drop menu-ui --nohist 2>&1)"; then
        lg E "drop failed with output: $output"
        exit 1
    fi
    lg . "drop finished with output[$output]"
}

function hide_ui() {
    lg . "running drop menui-ui --nohist"
    if ! output="$(drop menu-ui --nohist 2>&1)"; then
        lg E "drop failed with output: $output"
        exit 1
    fi
    lg . "drop finished with output[$output]"
}

logging_state="$LGENABLE"

lg I "beginning main loop: reading from fifo and processing"

while true; do
    export LGENABLE="$logging_state"

    lg F "loop start: awaiting input from fifo: $fifo_path"

    input="$(cat "$fifo_path")"
    lg F "got input from infile"

    if ui_is_hidden;
    then lg I "opening ui" ; show_ui &
    else lg I "menu-ui is already open, continuing"
    fi

    separator="$(echo "$input" | head -n 1)"
    list="$(echo "$input" | awk "/$separator/{section++; next} section==2")"
    lg . "got list '$(echo "$list" | tr '\n' ',')'"

    flag_allow_new=0
    flag_print_query=0
    flag_secure=0
    flag_fast=0

    while IFS= read -r flag; do
        case "$flag" in
            "--secure") flag_secure=1; lg . "set flag_secure[$flag_secure] NOTE: LOGGING WILL DISABLE" ;;
            "--allow-new") flag_allow_new=1; lg . "set flag_allow_new[$flag_allow_new]" ;;
            "--print-query") flag_print_query=1; lg . "set flag_print_query[$flag_print_query]" ;;
            "--fast") flag_fast=1; lg . "set flag_fast[$flag_fast]" ;;
        esac
    done < <(echo "$input" | awk "/$separator/{section++; next} section==1")

    if (( flag_secure )); then export LGENABLE=0;
    else export LGENABLE="$logging_state"; fi

    result=""

    if (( flag_allow_new )); then
        response="$(echo "$list" | fzf --print-query || :)"
        selected="$(echo "$response" | tail -n 1)"
        typed="$(echo "$response" | head -n 1)"
        [ "$(echo "$response" | wc -l)" == "1" ] && selected=""

        if echo "$typed" | grep -q "\*$"; then
            result="${typed%\*}" # a star signifies to use this input over anything else
        elif [ -z "$selected" ]; then
            result="$typed" # typed input is completey new
        else
            result="$selected" # it exists, and we prefer it always (except for "...*" case)
        fi
    elif (( flag_print_query )); then
        result="$(echo "$list" | fzf --print-query || :)"
    else
        result="$(echo "$list" | fzf || :)"
    fi

    if ui_is_hidden; then
        lg . "menu-ui is already hidden, finishing"
    else
        lg I "closing ui"
        if (( flag_fast ));
        then hide_ui &
        else hide_ui
        fi
    fi

    lg F "loop end: returning result to fifo: $(echo "$result" | tr '\n' '$')"

    echo "$result" > "$fifo_path"
done
