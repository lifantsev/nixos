{ pkgs, pkg_import, ... }: let pypr = pkgs.pyprland; in {
    execer = [ "cannot:${pypr}/bin/pypr" ];

    inputs = [
        (pkg_import ../../scripts/lg)
        pypr
    ];
}
