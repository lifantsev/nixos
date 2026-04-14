# menu/src.sh

# TODO pgrep for menu-ui, if not running, open it

export LGSTEM=menu
export LGSPEC=sh

flag_help=0
flag_secure=0
uiflag_allow_new=0
uiflag_print_query=0
uiflag_fast=0

lg start

while [ -n "${1:-}" ]; do
    case "$1" in
        "-h"|"--help") flag_help=1; lg . "set help: $flag_help" ;;
        "--secure") flag_secure=1; lg . "set flag_secure: $flag_secure NOTE: LOGGING WILL DISABLE";;

        "--fast") uiflag_fast=1; lg . "set uiflag_fast[$uiflag_fast]" ;;
        "--allow-new") uiflag_allow_new=1; lg . "set uiflag_allow_new: $uiflag_allow_new";;
        "--print-query") uiflag_print_query=1; lg . "set uiflag_print_query: $uiflag_print_query";;
    esac

    shift
done

fifo_path="$(menu-ui --getfifo)"

(( flag_secure )) && export LGENABLE=0

if (( flag_help )); then
    echo "'menu' is a dmenu like script"
    echo ""
    echo "pass choice options in stdin, separated by newlines"
    echo "menu will allow the user to choose one of these options, which will be printed to stdout"
    echo ""
    echo "-h | --help      : print this help menu"
    echo '--secure         : fully disable all logging'
    echo "--fast           : don't wait for menu-ui to close before exiting"
    echo "    NOTE: only one of the below may be passed"
    echo "--allow-new      : allow the user to create their own option instead of choosing from the presented ones"
    echo "--print-query    : 1st line of stdout is exactly what the user typed, 2nd line is the exact choice (usual output)"
    exit
fi

lg I "writing flag & options to fifo: $fifo_path"
separator="MENU FLAG OPTION SEPARATOR $(mktemp --dry-run XXXXXXXXXXXXXXXXXXXXXXXXXXXXX)"
echo "$(
    echo "$separator"
    (( flag_secure )) && echo "--secure"
    (( uiflag_allow_new )) && echo "--allow-new"
    (( uiflag_print_query )) && echo "--print-query"
    (( uiflag_fast )) && echo "--fast"
    echo "$separator"
    cat # pass stdin
)" > "$fifo_path"

lg I "awaiting result from fifo: $fifo_path"
result="$(cat "$fifo_path")"
lg . "got result[$(echo "$result" | tr '\n' '$')], printing"
echo "$result"
