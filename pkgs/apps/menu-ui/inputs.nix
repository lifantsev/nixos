{ pkgs, pkg_import, ... }: [
    (pkg_import ../../scripts/lg.sh)
    (pkg_import ../drop)
    pkgs.hyprland
    pkgs.fzf
    pkgs.gnugrep
    pkgs.gnused
]

