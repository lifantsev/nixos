# https://gist.github.com/vratiu/9780109
COL_DEFAULT="\033[0m"
COL_PROMPT="\033[0;34m"
COL_FAIL="\033[0;31m"
COL_SUCCESS="\033[0;32m"
COL_INFO="\033[0;33m"
COL_DARK="\033[0;37m"

function colorprint() { printf "$1$2$COL_DEFAULT"; }

function printmsg() {
    if [[ "$1" == "fail"* ]]; then
        colorprint "$COL_FAIL" "-> $1\n"
        return 1
    elif [[ "$1" == "info"* ]]; then
        colorprint "$COL_INFO" "-> $1\n"
    else
        colorprint "$COL_SUCCESS" "-> $1\n"
    fi

    return 0
}
