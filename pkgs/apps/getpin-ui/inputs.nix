{ pkgs, pkg_import, ... }: [
    (pkg_import ../../scripts/lg.sh)
    (pkg_import ../../scripts/color-helper.sh)
    (pkg_import ../drop)
    pkgs.hyprland
]
