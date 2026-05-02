{ pkgs, ... }: let
    pypr = pkgs.pyprland;
in {
    execer = [ "cannot:${pypr}/bin/pypr" ];

    inputs = [
        pkgs.lg
        pypr
    ];
}
