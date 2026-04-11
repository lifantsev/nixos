function diff() {
    [ -z "$1" ] && git diff && return

    arg="$1"
    shift

    if echo "$arg" | grep -q '^[0-9]$'; then
        git diff "HEAD~$arg" "$@"
    elif [ "$arg" == "c" ]; then
        git diff --cached "$@"
    else
        git diff "$arg" "$@"
    fi
}

function init() {
    [ -z "$(ls -A)" ] && echo "this directory is empty" && return
    [ -z "$1" ] && echo "please pass a remote adress" && return || remote="$1"

    [ -d ".crypt" ] && echo "this is already a crypt repo" && return
    [ -d ".git" ] && echo "this is already a git repo" && return
    [ -f ".git" ] && echo "file '.git' is blocking" && return

    git init
    git branch -M main
    git remote add origin "$remote"
    git add .
    git commit -m "INIT COMMIT from $(whoami)@$(hostname) at $(date +"%H:%M on %a %d.%m.%Y")"
    git push -u origin main
}

command="$1"
shift

"$command" "$@"
