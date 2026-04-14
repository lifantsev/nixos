# OLD FILE FOR REFERENCE
# ONLY STUFF LEFT HERE IS FEATUERES I DROPPED
# IN CASE I WANT TO GET THOSE FEATURES BACK
function hide() {
    # only run focuslast IF
    # - dropdown is focused
    # - there are other windows in the workspace to recofus onto
    numwindows="$(hyprctl activeworkspace -j | jq .windows)" # number of windows in workspace
    scratchfocused="$(hyprctl activewindow -j | grep -e '"class": "scratchpad",' -e '"title": "\[scratch\]')" # -n if a scratch window is focused

    [ "$numwindows" -gt 1 ] && [ -n "$scratchfocused" ] && hyprctl dispatch focuscurrentorlast &> /dev/null
}

function show() {
    drop_mon="$(hyprctl clients -j | jq ".[] | select(.workspace.name == \"special:scratch_$1\") | .monitor")"
    current_mon="$(hyprctl activeworkspace -j | jq .monitorID)"

    # drop_mon will be empty if this dropdown has never opened before (in which case we simply open it)
    if [ -z "$drop_mon" ] || [ "$drop_mon" == "$current_mon" ]; then
        pypr show "$1" > /dev/null
    else
        # if the drop is on another monitor we need to cycle it once before opening (for it to position correctly)
        hyprctl keyword animations:enabled false # to prevent visual annoyance
        pypr show "$1" > /dev/null
        pypr hide "$1" > /dev/null
        pypr show "$1" > /dev/null
        hyprctl keyword animations:enabled true
    fi

}
