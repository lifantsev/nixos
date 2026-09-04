{
    o = "e ../";
    oo = "e ../..";
    ooo = "e ../../..";
    oooo = "e ../../../..";
    ooooo = "e ../../../../..";
    oooooo = "e ../../../../../..";

    ssh = "gpg-connect-agent updatestartuptty /bye >/dev/null 2>&1; ssh";
    sshfs = "gpg-connect-agent updatestartuptty /bye >/dev/null 2>&1; sshfs";

    k = "mkdir -p";
    l = "touch";
    c = "chmod";
    r = "trash-put";
    z = "exit";

    src = "exec zsh";

    t = "eza -Ta";
    n = let eza = "eza -al --no-user --no-permissions --no-filesize --no-time";
        in "[ \"$(ls -a | wc -l)\" -gt 20 ] && ${eza} -G || ${eza}";

    q = "qalc";
}
