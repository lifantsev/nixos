# article about pinentry: https://velvetcache.org/2023/03/26/a-peek-inside-pinentry/
# pinentry documentation: https://gist.github.com/mdeguzis/05d1f284f931223624834788da045c65

export LGENABLE=1 # TODO set to 0 when done debugging
export LGSTEM=pinentry

if [ -z "${HYPRLAND_INSTANCE_SIGNATURE:-}" ]; then
    # shellcheck disable=SC2012
    # the files in this directory only have alphanumeric + underscores
    # so we'll use ls instead of find for simplicity
    hypr="$(ls -1t "$XDG_RUNTIME_DIR/hypr/" | head -n 1)"
    export HYPRLAND_INSTANCE_SIGNATURE="$hypr"
fi

lg start

lg I "HOME[$HOME]"
lg I "XDG_STATE_HOME[$XDG_STATE_HOME]"
lg I "XDG_RUNTIME_DIR[$XDG_RUNTIME_DIR]"
lg I "HYPRLAND_INSTANCE_SIGNATURE[${HYPRLAND_INSTANCE_SIGNATURE:-}]"

function bye() {
    lg I "terminating connection: assuan bye"
    echo BYE
    exit 1
}

function assuan() {
    lg . "  responding: $1"
    echo "$1"
}

desc=""
prompt=""
title=""
repeat=""

assuan "OK Pleased to meet you"

while :; do
    if ! read -r cmd args 2>/dev/null; then sleep 0.4; continue ; fi
    ok=1

    lg . "assuan got cmd[$cmd] with args[$args]"

    case "$cmd" in
        "BYE"*) assuan "OK Closing connection"; exit 0 ;;
        "GETPIN"*)
            # TODO if repeat is set -> act accordingly
            # TODO if error is set -> act accordingly

            lg I "getting pass using menu"
            lg . "  title[$title]"
            lg . "  desc[$desc]"
            lg . "  prompt[$prompt]"

            # TODO pass menu --secure
            # todo: display menu on currently focused terminal if it exists
            if ! res="$(echo -e "$title:\n${desc%%:*}\n=== $prompt ===" | menu --allow-new || :)"; then
                lg E "menu exited with an error!!!, exiting" > /dev/null
                bye
            fi

            lg I "got result starting with: '${res:0:3}'"

            if [ -n "$res" ]; then
                lg . "sending result back thru assuan"
                assuan "D $res"
            else
                assuan "ERR 83886179 Operation cancelled <menu>"; ok=0
            fi
            ;;

        "CONFIRM"*)
            if [ "$(echo -e 'yes\nno' | menu)" != "yes" ];
            then assuan "ERR 83886179 Operation cancelled <menu>"; ok=0
            fi
            ;;

        "MESSAGE"*) ;;

        "GETINFO"*) case "$args" in
            "pid" ) assuan "D $$" ;;
            "version" ) assuan "D 0" ;;
            "flavor" ) assuan "D pinentry-pypr" ;;
            "ttyinfo" ) assuan "D - - - - $(id -u 2>/dev/null || echo 0)/$(id -g 2>/dev/null || echo 0) -" ;;
        esac ;;
        "SETDESC"*)   desc="$args" ;;
        "SETPROMPT"*) title="$args" ;;
        "SETTITLE"*)  prompt="$args" ;;
        "SETREPEAT"*) repeat="$args" ;;
        "SETERROR"*) ;; # TODO, this should be reset by GETPIN

        "OPTION"*) ;;
        "SETKEYINFO"*) ;;

        # *) bye ;;
    esac

    (( ok )) && assuan "OK Success"
done

lg . "TODO REMOVE: $repeat$desc$title$prompt"
lg finish
