# qrcopy
{ pkgs, ... }: {
    execer = [ "cannot:${pkgs.wl-clipboard}/bin/wl-copy" ];

    inputs = [
        pkgs.qrtool
        pkgs.slurp
        pkgs.grim
        pkgs.mktemp

        pkgs.libnotify
        pkgs.wl-clipboard
    ];
}
