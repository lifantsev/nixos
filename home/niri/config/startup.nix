
{ ... }: {
    spawn-at-startup = [
        { argv = [ "mako" ];}
        { argv = [ "supervisor" "daemon" ];}
    ];
}
