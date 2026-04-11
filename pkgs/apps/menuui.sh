INFILE=/tmp/menu-in.fifo
OUTFILE=/tmp/menu-out.fifo

rm "$INFILE" > /dev/null
mkfifo "$INFILE"

rm "$OUTFILE" > /dev/null
mkfifo "$OUTFILE"

while true; do
    input="$(cat "$INFILE")"
    arg="$(echo "$input" | head -n 1)"
    list="$(echo "$input" | tail -n +2)"

    if [ "$arg" == "--allow-new" ]; then
        response="$(echo "$list" | fzf --print-query)"
        selected="$(echo "$response" | tail -n 1)"
        typed="$(echo "$response" | head -n 1)"
        [ "$(echo "$response" | wc -l)" == "1" ] && selected=""

        if echo "$typed" | grep -q "\*$"; then
            echo "$typed" | sed 's|\*$||' > "$OUTFILE" # a star signifies to use this input over anything else
        elif [ -z "$selected" ]; then
            echo "$typed" > "$OUTFILE" # typed input is completey new
        else
            echo "$selected" > "$OUTFILE" # it exists, and we prefer it always (except for "...*" case)
        fi
    elif [ "$arg" == "--print-query" ]; then
        echo "$list" | fzf --print-query > "$OUTFILE"
    else
        echo "$list" | fzf > "$OUTFILE"
    fi
done
