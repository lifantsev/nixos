# getpin

export LGSTEM="getpin"
export LGSPEC="sh"

lg start

function finish() { lg finish ; exit "$1" ; }

flag_fifo=0
fifo_name=""
flag_desc=""
flag_prompt=""
flag_error=""

while [ -n "${1:-}" ]; do
    lg I "handling flag[$1]"

    case "$1" in
        "--fifo") # set fifo stem to use
            if [ -z "${2:-}" ] || [[ "$2" == "-"* ]];
            then lg E "option --fifo expects an argument, but it was either not provided or invalid, exiting"; finish 1; fi

            flag_fifo=1
            lg . "set flag_fifo[$flag_fifo]"
            fifo_name="$2" ; shift
            lg . "set fifo_name[$fifo_name]"
        ;;
        "--desc")
            if [ -z "${2:-}" ] || [[ "$2" == "-"* ]];
            then lg E "option --desc expects an argument, but it was either not provided or invalid, exiting"; finish 1; fi

            flag_desc="$2" ; shift
            lg . "set flag_desc[$flag_desc]"
        ;;
        "--prompt")
            if [ -z "${2:-}" ] || [[ "$2" == "-"* ]];
            then lg E "option --prompt expects an argument, but it was either not provided or invalid, exiting"; finish 1; fi

            flag_prompt="$2" ; shift
            lg . "set flag_prompt[$flag_prompt]"
        ;;
        "--error")
            if [ -z "${2:-}" ] || [[ "$2" == "-"* ]];
            then lg E "option --error expects an argument, but it was either not provided or invalid, exiting"; finish 1; fi

            flag_error="$2" ; shift
            lg . "set fifo_name[$flag_error]"
        ;;
        *)
            lg E "unrecognized flag[$1]"
            finish 1
        ;;
    esac

    shift
done

if (( flag_fifo ));
then fifo_path="$(getpin-ui --fifo "$fifo_name" --getfifo)"
else fifo_path="$(getpin-ui --getfifo)"
fi

lg I "writing request to fifo[$fifo_path]"

echo "$(
    echo "$flag_desc"
    echo "$flag_prompt"
    echo "$flag_error"
)" > "$fifo_path"

lg . "awaiting result from fifo[$fifo_path]"
pin="$(cat "$fifo_path")"
lg . "printing resu;t"
echo "$pin"
