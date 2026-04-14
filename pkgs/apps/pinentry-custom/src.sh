# article about pinentry: https://velvetcache.org/2023/03/26/a-peek-inside-pinentry/
# pinentry documentation: https://gist.github.com/mdeguzis/05d1f284f931223624834788da045c65

export LGENABLE=0 # other apps inherit this, but pinentry runs in a clean environment (need to set manually)
export LGSTEM=pinentry

if [ -z "${HYPRLAND_INSTANCE_SIGNATURE:-}" ]; then
    # shellcheck disable=SC2012
    # we use ls instead of find b/c this directory is a predictable environment
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

if ! command -v getpin &> /dev/null;
then lg E "getpin is not available in this environment, exiting" ; bye
fi

if ! command -v sed &> /dev/null;
then lg E "sed is not available in this environment, exiting" ; bye
fi

prompt="Passphrase"
desc=""
error=""
repeat=""

assuan "OK Pleased to meet you"

while :; do
    if ! read -r cmd args 2>/dev/null; then sleep 0.4; continue ; fi
    ok=1

    lg . "assuan got cmd[$cmd] with args[$args]"

    case "$cmd" in
        "BYE"*) assuan "OK Closing connection"; exit 0 ;;
        "GETPIN"*)
            desc_head="$(echo "$desc" | head -n 1 | sed -e 's|Please enter the passphrase to|Please|' -e 's|^\s*||' -e 's|\s*$||')"
            desc_tail="$(echo "$desc" | tail -n +2 | sed -e 's|^\s*||' -e 's|\s*$||')"
            [ -n "$desc_tail" ] && desc_tail+="\n"

            # todo: show pinentry prompt on currently open terminal, if that exists

            if [ -z "$repeat" ]; then
                lg I "getting pin"

                if ! pin="$(getpin --title "$desc_head" --desc "$desc_tail" --prompt "$prompt" --error "$error")"
                then pin=""; fi
            else
                while true; do
                    lg I "getting pin"

                    if ! pin="$(getpin --donthide --title "$desc_head" --desc "$desc_tail" --prompt "$prompt" --error "$error")"
                    then pin=""; fi
                    [ -z "$pin" ] && break

                    error=""

                    lg I "getting repeat pin"

                    if ! repeat_pin="$(getpin --donthide --title "$desc_head" --desc "$desc_tail" --prompt "$repeat" --error "$error")"
                    then repeat_pin=""; fi

                    [ -z "$repeat_pin" ] && pin="" && break # break on cancel

                    if [ "$repeat_pin" == "$pin" ]; then
                        lg I "success: pins match"
                        assuan "S PIN_REPEATED"
                        break
                    else
                        lg I "fail: pins didn't match, trying again"
                        error="Did not match"
                    fi
                done

                getpin --justhide &
            fi

            if [ -n "$pin" ];
            then assuan "D $pin"
            else assuan "ERR 83886179 Operation cancelled <getpin>"; ok=0
            fi

            # reset
            repeat=""
            error=""
        ;;
        "CONFIRM"*)
            if ! res="$(getpin --showpin --title "Please confirm: $desc" --prompt "[yes]/no")"; then
                lg E "getpin exited with an error, using res=no" > /dev/null # devnull to not screw with assuan ipc
                res="no"
            fi

            if [[ "${res,,}" == "n"* ]]; then
                assuan "ERR 83886179 Operation cancelled <getpin>"; ok=0
            fi
        ;;
        "MESSAGE"*)
            getpin --title "$desc" --desc "Press enter to dismiss" ||:
        ;;
        "SETDESC"*)
            # args=Please enter the passphrase... %0A %22 followed by <keyinfo>
            # shellcheck disable=SC2059
            desc="$(printf "${args//\%/\\x}")"
            ;;
        "SETPROMPT"*) prompt="${args%:}" ;; # Passphrase:
        "SETERROR"*) error="${args#Bad }" ;; # Bad Passphrase (try 2 of 3)

        "SETREPEAT"*) repeat="$args" ;;

        "GETINFO"*) case "$args" in
            "pid" ) assuan "D $$" ;;
            "version" ) assuan "D 0" ;;
            "flavor" ) assuan "D pinentry-pypr" ;;
            "ttyinfo" ) assuan "D - - - - $(id -u 2>/dev/null || echo 0)/$(id -g 2>/dev/null || echo 0) -" ;;
        esac ;;
    esac

    (( ok )) && assuan "OK Success"
done

lg finish
