LGPATH="$XDG_STATE_HOME/logs"
mkdir -p "$LGPATH"

[ -z "${1:-}" ] && echo "lg err: please pass 1st arg" && exit 1

if [ "$1" == "view" ]; then $EDITOR "$LGPATH/$2.log" ; exit 0 ; fi
if [ "$1" == "tail" ]; then tail -n 15 "$LGPATH/$2.log" ; exit 0 ; fi
if [ "$1" == "watch" ]; then watch -n 0.5 tail -n 15 "$LGPATH/$2.log" ; exit 0 ; fi
# TODO clear option
# and clear all maybe

[ -z "${LGENABLE:-}" ] && echo "lg err: LGENABLE is unset" && exit 1
(( ! LGENABLE )) && exit 0

[ -z "${LGSTEM:-}" ] && echo "lg err: LGSTEM is unset" && exit 1

prefix=""
[ -n "${LGSPEC:-}" ] && prefix="$LGSPEC: "

if [ "$1" == "finish" ] || [ "$1" == "start" ]; then
    echo "$prefix$1" >> "$LGPATH/$LGSTEM.log" 2>/dev/null
    exit 0
fi

[ -z "$2" ] && echo "lg err: please pass 2nd arg" && exit 1

msg="$2"
if [ "$msg" == "-" ]; then msg="$(cat)"; fi
if [ -z "$msg" ]; then exit 0; fi

echo "$1 $(date +"%H:%M @ %S.%3N") $1 $prefix$msg" >> "$LGPATH/$LGSTEM.log" 2>/dev/null
[ "$1" == E ] && echo "$LGSTEM $prefix error: $msg"

exit 0
