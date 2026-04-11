INFILE=/tmp/menu-in.fifo
OUTFILE=/tmp/menu-out.fifo

# allow callers to pre-open the dropdown window,
# because sometimes it looks too slow
# when we open the dropdown all the way here

# TODO use 'pypr show' instead of 'drop nohistory'
# TODO allow any flag order

if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
    echo "'menu' is a dmenu like script"
    echo ""
    echo "pass choice options in stdin, separated by newlines"
    echo "menu will allow the user to choose one of these options, which will be printed to stdout"
    echo ""
    echo "-h | --help      : print this help menu"
    echo "--menuui-is-open : you can show the menu ui using pypr yourself, to make it appear faster"
    echo "                   if you do, pass this option"
    echo "                   NOTE: this must be passed as the first flag"
    echo "--allow-new      : allow the user to create their own option instead of choosing from the presented ones"
    echo "--print-query    : 1st line of stdout is exactly what the user typed, 2nd line is the exact choice (usual output)"
    exit
fi

if [ "$1" == "--menuui-is-open" ];
then shift
else drop menu nohistory; fi

echo "$(
    echo "$1" # pass flag
    cat # pass stdin
)" > "$INFILE"

cat "$OUTFILE"

drop menu nohistory

# hyprctl dispatch focuscurrentorlast &> /dev/null
