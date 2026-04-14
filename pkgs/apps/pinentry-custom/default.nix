{ pkgs, pkg_import, ... }: let getpin = pkg_import ../getpin; in {
    execer = [ "cannot:${getpin}/bin/getpin" ];

    inputs = [
        getpin
        (pkg_import ../../scripts/lg.sh)
        pkgs.gnused
    ];
}
