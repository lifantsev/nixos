# allow callers to pre-open the dropdown window,
# because sometimes it looks too slow
# when we open the dropdown all the way here

if [ "$1" == "--menuui-is-open" ];
then shift
else drop menu nohistory; fi

echo "$(
    echo "$1" # pass flag
    cat # pass stdin
)" > /tmp/menu-in.fifo

cat /tmp/menu-out.fifo

drop menu nohistory

# hyprctl dispatch focuscurrentorlast &> /dev/null
