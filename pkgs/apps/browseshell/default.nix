{ pkgs, pkg_import, ... }: let
    xioxide = pkg_import ../xioxide.sh;
in {
    execer = [
        "cannot:${xioxide}/bin/xioxide"
        "cannot:${pkgs.niri}/bin/niri"
        "cannot:${pkgs.dropmenu}/bin/dropmenu"
        "cannot:${pkgs.niridrop}/bin/niridrop"
        "cannot:${pkgs.zen-beta}/bin/zen-beta"
    ];

    keep."$browser" = true;

    inputs = [
        xioxide

        pkgs.niridrop
        pkgs.dropmenu

        pkgs.zen-beta
        pkgs.niri
        pkgs.python3
        pkgs.jq
        pkgs.gnugrep
        pkgs.gnused
        pkgs.gawk
    ];
}

