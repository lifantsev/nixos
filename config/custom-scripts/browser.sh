case "$1" in
    "new-window")
        case "$BROWSER" in
            "org.qutebrowser.qutebrowser") qutebrowser ;;
        esac
        ;;
    "new-tab")
        case "$BROWSER" in
            "org.qutebrowser.qutebrowser") qutebrowser ":open -t $2" &>/dev/null ;;
        esac
        ;;
    "get-url")
        case "$BROWSER" in
            "org.qutebrowser.qutebrowser") 
                # start the url updater if it isn't running yet
                if [ ! -n "$(pgrep -f 'bash [^ ]*qutebrowser/userscripts/urlupdater.sh')" ]; then
                    qutebrowser ":spawn --userscript urlupdater.sh" &> /dev/null
                    sleep 0.5 # wait for first url fetch
                fi
                cat /tmp/qute_url ;;
        esac
        ;;
    "help")
        echo "help page for `browser`, a general interface for browsers"
        echo
        echo "new-window"
        echo "    opens a new empty window"
        echo
        echo "new-tab"
        echo "    opens the url passed in a new tab"
        echo
        echo "get-url"
        echo "    prints the url of the currently open page"
        echo
        ;;
esac
