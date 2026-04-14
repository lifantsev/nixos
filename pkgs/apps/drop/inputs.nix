{ pkgs, pkg_import, ... }: [
    (pkg_import ../../scripts/lg.sh)
    pkgs.pyprland
]
