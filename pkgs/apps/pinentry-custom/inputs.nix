{ pkgs, pkg_import, ... }: [
    (pkg_import ../getpin)
    (pkg_import ../../scripts/lg.sh)
    pkgs.gnused
]

