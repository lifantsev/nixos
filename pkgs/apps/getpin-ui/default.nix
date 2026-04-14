{ pkgs, pkg_import, ... }: let drop = pkg_import ../drop; in {
    execer = [ "cannot:${drop}/bin/drop" ];

    inputs = [
        drop
        (pkg_import ../../scripts/lg.sh)
        (pkg_import ../../scripts/color-helper.sh)
        pkgs.ncurses # clear
        pkgs.hyprland
        pkgs.jq
        pkgs.gnugrep
        pkgs.gawk
    ];
}
