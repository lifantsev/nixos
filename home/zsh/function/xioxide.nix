{ config, ... }: with config.programs.zsh.shellAliases; /*bash*/ ''
    e() { cd "$(xioxide paths "$1")" && ${n}; }
    ke() { ${k} "$1" && e "$1"; }
    a() { lf "$(xioxide paths "$1")"; }
    h() { [ -z "$1" ] && $EDITOR . || $EDITOR "$(xioxide paths "$1")"; }
''
