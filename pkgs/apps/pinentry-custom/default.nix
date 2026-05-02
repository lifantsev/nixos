{ pkgs, pkg_import, ... }: let
    getpin = pkg_import ../getpin;
    getpin-ui = pkg_import ../getpin-ui;
in {
    execer = [
        "cannot:${getpin}/bin/getpin"
        "cannot:${getpin-ui}/bin/getpin-ui"
    ];

    inputs = [
        getpin getpin-ui
        pkgs.lg
        pkgs.gnused
        pkgs.psmisc
    ];
}
