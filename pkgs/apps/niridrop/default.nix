{ pkgs, pkg_import, ... }: let
    niri = pkgs.niri;
in {
    execer = [
        "cannot:${niri}/bin/niri"
    ];

    inputs = [
        pkgs.lg
        niri
        pkgs.jq
        pkgs.gnugrep
        pkgs.gawk
    ];
}
