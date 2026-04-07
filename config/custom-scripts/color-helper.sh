# https://gist.github.com/vratiu/9780109
COL_DEFAULT="\033[0m"
COL_PROMPT="\033[0;34m"
COL_FAIL="\033[0;31m"
COL_SUCCESS="\033[0;32m"
COL_INFO="\033[0;33m"

function colorprint() { printf "$1$2$COL_DEFAULT"; }
