{ pkgs, pkg_import, ... }: let
    niri = pkgs.niri;
in {
    execer = [
        "cannot:${niri}/bin/niri"
    ];

    inputs = [
        (pkg_import ../../scripts/lg.sh)
        niri
        pkgs.jq
        pkgs.gnugrep
        pkgs.gawk
    ];
}
