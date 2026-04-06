{ config, ... }: with config.programs.zsh.shellAliases; /*bash*/ ''
    e() { 
        local dir="$(xioxide paths "$1")"
        [ -n "$dir" ] && cd "$dir" || cd
        ${n}
    }
    ke() { ${k} "$1" && e "$1"; }
    a() {
        lastdir="$(lf -print-last-dir "$(xioxide paths "$1")")"
        if [ -f /tmp/lfcd ]; then e "$lastdir" ; rm /tmp/lfcd; fi
    }
    h() { [ -z "$1" ] && $EDITOR . || $EDITOR "$(xioxide paths "$1")"; }
''
