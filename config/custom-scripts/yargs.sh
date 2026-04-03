[ "$1" == "-E" ] && esc="$2" && shift 2 || esc="%%%"
eval "$(cat | sed "s|$esc|$1|g")"
