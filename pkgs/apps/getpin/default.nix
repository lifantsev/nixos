{ pkg_import, ... }: let getpin-ui = pkg_import ../getpin-ui; in {
    execer = [ "cannot:${getpin-ui}/bin/getpin-ui" ];

    inputs = [
        getpin-ui
        (pkg_import ../../scripts/lg.sh)
    ];
}
