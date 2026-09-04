{ ... }: {
    spawn-at-startup = [
        { argv = [ "mako" ];}
        { argv = [ "manager" "daemon" ];}
    ];
}
