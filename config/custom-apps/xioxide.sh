# usage: xioxide <myconfig> <pattern> <args>
#     myconfig specifies which entries in .config/xioxide to use
#     pattern specifies what to search through it by (prefix of '.' is replaced by current entry)
#     args:
#         --no-passthrough: if there were no matches, print no output (by default it regurgitates <pattern>)

cfg_stem="$1"
originalinput="$2"
args="$3"

config="$XDG_CONFIG_HOME/xioxide/$cfg_stem"
input="$originalinput"

[ ! -f "$config.binds" ] && echo "ERR: binds dont exist: $config.binds" >&2 && exit 1

# apply sed processing if available
[ -f "$config.sed" ] && input="$(echo "$input" | sed -f "$config.sed")"

# expand predot if present
if [ "${input:0:1}" == "." ]; then
    [ ! -f "$config.current" ] && echo "ERR: attempted using predot without $config.current setup" >&2 && exit 1

    current="$(sh "$config.current")" # sed is to escape . ^ $ (for grepping)
    curname="$(cat "$config.binds" | grep -F "$current" | head -n 1 | awk '{ print $1 }')"

    [ ! -n "$curname" ] && echo "ERR: not currently in a '$cfg_stem' bind entry: $current" >&2 && exit 1

    input="$curname${input:1}"
fi

output="$(cat "$config.binds" | grep "^$input " | sed 's|^[^ ]* ||')"

if [ -n "$output" ]; then
    echo "$output"
else
    [ "$args" != "--no-passthrough" ] && echo "$originalinput"
fi
