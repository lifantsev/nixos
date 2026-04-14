{ pkgs, lib, ... }@args: let 
    input_args = args // { inherit pkg_import; };
    pkg_import = fpath:
        if lib.hasSuffix ".nix" fpath then
            pkgs.callPackage fpath {}
        else if lib.hasSuffix ".sh" fpath then
            pkgs.writeShellScriptBin (builtins.elemAt (builtins.match "^(.*)\\.[a-z]*$" (builtins.baseNameOf fpath)) 0)
            (builtins.readFile fpath)
            # pkgs.writeShellScriptApplication {
            #     name = builtins.elemAt (builtins.match "^(.*)\\.[a-z]*$" (builtins.baseNameOf fpath)) 0;
            #     text = builtins.readFile fpath;
            # }
        else
            pkgs.writeShellApplication {
                name = builtins.baseNameOf fpath;
                text = builtins.readFile (fpath + "/src.sh");
                runtimeInputs = [ pkgs.coreutils ] ++ import (fpath + "/inputs.nix") input_args;
            };
in pkg_import
