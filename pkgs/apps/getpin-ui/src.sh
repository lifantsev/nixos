# getpin-ui

export LGSTEM="getpin"
export LGSPEC="ui"

lg start

function finish() { lg finish ; exit "$1" ; }

# NOTE these functions assume hyprland + pyprland
function ui_is_hidden() {
    if [ -z "${HYPRLAND_INSTANCE_SIGNATURE:-}" ]; then
        lg E "HYPRLAND_INSTANCE_SIGNATURE is not set! this is needed by hyprctl to work properly"
        exit 1
    fi

    lg . "checking if ui_is_hidden using hyprctl"
    hyprctl clients -j |
        jq -r 'first(.[] | select(.class == "scratchpad" and .title == "getpin-ui") | .workspace.name)' |
        grep -q '^special'
}

function show_ui() {
    lg . "running drop getpin-ui --nohist"
    if ! output="$(drop getpin-ui --nohist 2>&1)"; then
        lg E "drop failed with output: $output"
        exit 1
    fi
    lg . "drop finished with output[$output]"
}

function hide_ui() {
    lg . "running drop getpin-ui --nohist"
    if ! output="$(drop getpin-ui --nohist 2>&1)"; then
        lg E "drop failed with output: $output"
        exit 1
    fi
    lg . "drop finished with output[$output]"
}

function starread() {
    # read char by char & print stars as we go

    while IFS= read -r -s -n 1 char; do
        if [[ -z "$char" ]]; then echo ; break ; fi # handle <CR>

        if [[ "$char" == $'\x08' || "$char" == $'\x7f' ]]; then # handle <BS>
            if [[ -n "$pin" ]]; then
                pin="${pin%?}"
                echo -en "\b \b" # back, print space, back
            fi
        else
            pin+="$char"
            printf "*"
        fi
    done
}

flag_getfifo=0
flag_justhide=0
flag_once=0
flag_fifo=0
fifo_name=default

while [ -n "${1:-}" ]; do
    case "$1" in
        "--fifo") # set fifo stem to use
            if [ -z "${2:-}" ] || [[ "$2" == "-"* ]]; then
                lg E "option --fifo expects an argument, but it was either not provided or invalid"
                finish 1
            fi

            flag_fifo=1
            lg . "set flag_fifo[$flag_fifo]"
            fifo_name="$2" ; shift
            lg . "set fifo_name[$fifo_name]"
        ;;
        "--getfifo") # just print fifo path
            flag_getfifo=1
            lg . "set flag_getfifo[$flag_getfifo]"
        ;;
        "--justhide") # just hide ui
            flag_justhide=1
            lg . "set flag_justhide[$flag_justhide]"
        ;;
        "--once") # only serve one request before exiting
            lg . "set flag_once[$flag_once]"
            flag_once=1
        ;;
        *)
            lg E "unrecognized flag[$1]"
            finish 1
        ;;
    esac

    shift
done

if (( flag_justhide )); then
    if ui_is_hidden;
    then lg . "ui is already hidden, finishing"
    else lg I "closing ui" ; hide_ui &
    fi

    finish 0
fi

fifo_path="$XDG_STATE_HOME/getpin/$fifo_name.fifo"

if (( flag_getfifo )); then
    lg I "printing fifo_path[$fifo_path] and exiting..."
    echo "$fifo_path"
    finish 0
fi

if [ -e "$fifo_path" ]; then # we ignore the chance there is a directory here
    lg I "removing existing fifo: $fifo_path"
    rm "$fifo_path" &> /dev/null || :
fi

lg I "initializing fifo: $fifo_path"
mkdir -p "$(dirname "$fifo_path")"
mkfifo "$fifo_path"

# shellcheck disable=SC1091
# this is in runtime inputs
source color-helper

while true; do
    lg F "awaiting input from fifo: $fifo_path"
    clear

    input="$(cat "$fifo_path")"
    lg . "got input from infile"

    showpin="$(echo "$input" | awk -v RS='\x1F' 'NR==1')"
    donthide="$(echo "$input"| awk -v RS='\x1F' 'NR==2')"
    title="$(echo "$input"   | awk -v RS='\x1F' 'NR==3')"
    desc="$(echo "$input"    | awk -v RS='\x1F' 'NR==4')"
    prompt="$(echo "$input"  | awk -v RS='\x1F' 'NR==5')"
    error="$(echo "$input"   | awk -v RS='\x1F' 'NR==6')"

    if (( ! flag_fifo )); then # let user handle showing ui if they are using custom fifo
        if ui_is_hidden;
        then lg I "opening ui" ; show_ui &
        else lg I "ui is already open, continuing"
        fi
    fi

    [ -n "$title" ] && colorprint "$COL_PROMPT" "$title\n"
    [ -n "$desc" ] && colorprint "$COL_DARK" "$desc\n"

    if [ -n "$error" ]
    then colorprint "$COL_FAIL" "$error: "
    else
        [ -n "$prompt" ] && colorprint "$COL_SUCCESS" "$prompt: "
    fi

    pin=""
    if (( showpin ));
    then read -r pin
    else starread
    fi

    lg F "returning [[pin]] to fifo"

    echo "$pin" > "$fifo_path"

    if (( ! flag_fifo )) && (( ! donthide )); then
        if ui_is_hidden;
        then lg . "ui is already hidden, finishing"
        else lg I "closing ui" ; hide_ui &
        fi
    fi

    if (( flag_once )); then
        lg I "we got --once, finishing up"
        lg . "removing fifo[$fifo_path]"
        rm "$fifo_path" &> /dev/null || :

        lg . "exiting..."
        finish 0
    fi
done
