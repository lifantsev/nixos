{ ... }: {
    spawn-at-startup = [
        { argv = [ "mako" ];}
        { argv = [ "manager" "daemon" ];}
        { argv = [ "awww-daemon" ];}
    ];
}
