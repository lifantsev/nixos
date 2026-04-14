{ pkgs, pkg_import, ... }: [
    (pkg_import ../../scripts/lg.sh)
    pkgs.fzf
    pkgs.gnugrep
    pkgs.gnused
]

