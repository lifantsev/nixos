{ pkgs, pkg_import, ... }: let
    drop = pkg_import ../drop;
    fzf = pkgs.fzf;
in {
    execer = [
        "cannot:${drop}/bin/drop"
        "cannot:${fzf}/bin/fzf"
    ];

    inputs = [
        drop
        fzf
        pkgs.lg
        pkgs.hyprland
        pkgs.jq
        pkgs.gnugrep
        pkgs.gnused
        pkgs.gawk
    ];
}
