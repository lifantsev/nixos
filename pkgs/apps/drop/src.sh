# drop/src.sh

# TODO don't depend on FILE_CURR, use hyprctl to figure that out
# only use FILE_LAST

FILE_LAST="$XDG_STATE_HOME/drop/last"
FILE_CURR="$XDG_STATE_HOME/drop/curr"

mkdir -p "$(dirname "$FILE_LAST")"
mkdir -p "$(dirname "$FILE_CURR")"

export LGSTEM=drop

last=""
curr=""

function load_last() { last="$(cat "$FILE_LAST")"; lg . "loaded last: '$last'"; }
function load_curr() { curr="$(cat "$FILE_CURR")"; lg . "loaded curr: '$curr'"; }
function save_last() { echo "$1" > "$FILE_LAST"; lg . "saved last: '$1'"; }
function save_curr() { echo "$1" > "$FILE_CURR"; lg . "saved curr: '$1'"; }
function finish() { lg finish; exit 0; }

function show_id() {
    if [ -z "${1:-}" ]; then lg E "show_id ran without id passed"; return 1; fi

    lg F "show_id: running pypr show '$1'"
    pypr_err="$(pypr show "$1" 2>&1 1>/dev/null)"
    if [ -n "$pypr_err" ]; then lg E "pypr: $pypr_err, exiting" ; exit 1 ; fi
    lg . "pypr show complete"

    save_curr "$1"
    (( ! no_history )) && save_last "$1"

    return 0
}

function hide_id() {
    if [ -z "${1:-}" ]; then lg E "hide_id ran without id passed"; return 1; fi

    lg F "hide_id: running pypr hide '$1'"
    pypr_err="$(pypr hide "$1" 2>&1 1>/dev/null)"
    if [ -n "$pypr_err" ]; then lg E "pypr: $pypr_err, exiting" ; exit 1 ; fi
    lg . "pypr hide complete"

    save_curr ""

    return 0
}

############
# GET ARGS #
############

lg start

no_history=0
init=0
dump=0
id=""
while [ -n "${1:-}" ]; do
    case "$1" in
        "--nohist"|"-n") no_history=1; lg . "set no-history: $no_history" ;;
        "--init") init=1; lg . "set init: $init" ;;
        "--dump") dump=1; lg . "set dump: $dump" ;;
        # TODO add --show and --hide
        # --show with no arg should show last UNLESS there is a current
        # --hide with no arg should hide current && noop if no current
        # --hide with id should hide if current=id && noop otherwise
        # --show with id should show unless current=id
        "-"*) lg E "received unrecognized flag[$1], exiting" ; exit 1 ;;
        *) id="$1"; lg . "set id: '$id'" ;; # TODO add some sort of check that id is legal
    esac

    shift
done

########
# MAIN #
########

lg F "beginning of main!"

if (( init )); then
    lg . "--init passed, emptying save files & exiting"
    save_last ""
    save_curr ""
    finish
fi

load_last
load_curr

if (( dump )); then
    lg . "dump mode enabled, printing info & exiting"
    echo "last='$last'"
    echo "curr='$curr'"
    echo "FILE_LAST='$FILE_LAST'"
    echo "FILE_CURR='$FILE_CURR'"
    echo ""
    echo "id='$id'"
    echo "no_history='$no_history'"
    echo "init='$init'"
    echo "dump='$dump'"
    finish
fi

if [ -z "${HYPRLAND_INSTANCE_SIGNATURE:-}" ]; then
    lg E "HYPRLAND_INSTANCE_SIGNATURE is not set! this is needed by pypr to work properly"
    exit 1
fi

if [ -z "${XDG_RUNTIME_DIR:-}" ]; then
    lg E "XDG_RUNTIME_DIR is not set! this is needed for pypr to work properly"
    exit 1
fi

if [ -n "$curr" ]; then
    lg . "'$curr' is open, hiding to make room for next"
    hide_id "$curr"

    lg . "checking id[$id] against curr[$curr]"
    if [ -z "$id" ] || [ "$id" == "$curr" ]; then
        lg . "id passed was empty or equal to curr, so closing current window was all we had to do, exiting"
        finish
    fi
fi


if [ -z "$id" ]; then
    lg . "id is empty, just opening last window"
    show_id "$last"
else
    lg . "opening '$id'"
    show_id "$id"
fi

finish
