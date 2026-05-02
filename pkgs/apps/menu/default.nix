{ pkgs, pkg_import, ... }: let menu-ui = pkg_import ../menu-ui; in {
    execer = [ "cannot:${menu-ui}/bin/menu-ui" ];

    inputs = [
        menu-ui
        pkgs.lg
    ];
}
