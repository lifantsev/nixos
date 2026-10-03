{ ... }: {
    spawn-at-startup = [
        { argv = [ "mako" ];}
        { argv = [ "manager" "daemon" ];}
        { argv = [ "barless" "--daemon" ];}
        { argv = [ "awww-daemon" ];}
        { argv = [ "killall" "makima" ];} # restart makima daemon
    ];
}
