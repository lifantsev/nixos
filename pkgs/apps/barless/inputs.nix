{ pkgs, pkg_import, ... }: [
    (pkg_import ../plyr.sh)
    (pkg_import ../../scripts/rustranslit.sh)
    pkgs.wireplumber # wpctl
    pkgs.gawk # awk
    pkgs.gnused # sed
    pkgs.mako # makoctl
    pkgs.libnotify # notify-send
    pkgs.bc
    pkgs.brightnessctl
    pkgs.upower
    pkgs.iconv
]
