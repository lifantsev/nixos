MAX_RECENTS=7
SAVE_FILE=/tmp/launcher.recents
[ -f $SAVE_FILE ] || touch $SAVE_FILE

function load_recents() { RECENT_LAUNCHES="$(cat $SAVE_FILE)"; }
function save_recents() { echo "$RECENT_LAUNCHES" > $SAVE_FILE; }

function add_program_to_recents() {
    # bottom is newest
    RECENT_LAUNCHES="$(
        if echo "$RECENT_LAUNCHES" | grep -q "^$program$"; then
            # list already has this entry, move it to bottom
            echo "$RECENT_LAUNCHES" | sed "/^$program$/d"
        elif [ "$(echo "$RECENT_LAUNCHES" | wc -l)" -ge $MAX_RECENTS ]; then
            # we need to remove one entry
            echo "$RECENT_LAUNCHES" | tail -n +2
        else
            # we can just add another entry
            echo "$RECENT_LAUNCHES"
        fi

        echo "$program"
    )"
}

function construct_list() {
    find ${PATH//:/ } -maxdepth 1 -executable 2>/dev/null | awk -F "/" '{ print $NF }' | sort | grep -v "\[\|^\."

    [ -n "$RECENT_LAUNCHES" ] && echo "$RECENT_LAUNCHES"
}

function select_program() {
    program="$(construct_list | tac | fzf)"
    [ -z "$program" ] && exit
}

load_recents
select_program
add_program_to_recents
save_recents

"$program"
