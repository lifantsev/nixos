{ pkgs, lib, ... }@args: let 
    input_args = args // { inherit pkg_import; };
    pkg_import = fpath:
        if lib.hasSuffix ".nix" fpath then
            pkgs.callPackage fpath {}
        else if lib.hasSuffix ".sh" fpath then
            pkgs.writeShellScriptBin (builtins.elemAt (builtins.match "^(.*)\\.[a-z]*$" (builtins.baseNameOf fpath)) 0)
            (builtins.readFile fpath)
        else
            pkgs.resholve.writeScriptBin (builtins.baseNameOf fpath) (let
                settings = import fpath input_args;
            in {
                interpreter = "${pkgs.bash}/bin/bash";
                inputs = [ pkgs.coreutils ] ++ settings.inputs;
                execer = (settings.execer or []) ++ (if fpath != ./scripts/lg then [ "cannot:${pkg_import ./scripts/lg}/bin/lg" ] else []);
            }) (builtins.readFile (fpath + "/src.sh"));
in pkg_import
