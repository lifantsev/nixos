{ pkgs, lib, ... }@args: let 
    input_args = args // { inherit pkg_import; };
    pkg_import = fpath:
        if lib.hasSuffix ".nix" fpath then
            pkgs.callPackage fpath {}
        else if lib.hasSuffix ".sh" fpath then
            pkgs.writeShellScriptBin (builtins.elemAt (builtins.match "^(.*)\\.[a-z]*$" (builtins.baseNameOf fpath)) 0)
            (builtins.readFile fpath)
        else if (builtins.readFileType fpath == "directory") then
            if (builtins.pathExists (fpath + "/src.sh")) then
                pkgs.resholve.writeScriptBin (builtins.baseNameOf fpath) (let
                    settings = import fpath input_args;
                in {
                    interpreter = "${pkgs.bash}/bin/bash";
                    inputs = [ pkgs.coreutils ] ++ settings.inputs;
                    execer = (settings.execer or []) ++ [ "cannot:${pkgs.lg}/bin/lg" ];
                }) (builtins.readFile (fpath + "/src.sh"))
            else
                pkgs.callPackage fpath {}
        else {};
in pkg_import
