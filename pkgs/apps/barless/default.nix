{ pkgs, pkg_import, ... }: let
    plyr = pkg_import ../plyr.sh;
    makoctl = pkgs.mako;
    iconv = pkgs.iconv;
in {
    execer = [
        "cannot:${plyr}/bin/plyr"
        "cannot:${makoctl}/bin/makoctl"
        "cannot:${iconv}/bin/iconv"
    ];

    inputs = [
        plyr makoctl iconv

        (pkg_import ../../scripts/rustranslit.sh)
        pkgs.wireplumber # wpctl
        pkgs.gawk # awk
        pkgs.gnused # sed
        pkgs.libnotify # notify-send
        pkgs.bc
        pkgs.brightnessctl
        pkgs.upower
    ];
}
