{ pkg_import, ... }: let menu-ui = pkg_import ../menu-ui; in {
    execer = [ "cannot:${menu-ui}/bin/menu-ui" ];

    inputs = [
        menu-ui
        (pkg_import ../drop)
        (pkg_import ../../scripts/lg)
    ];
}
