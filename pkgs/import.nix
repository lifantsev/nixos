{ pkgs, lib, ... }: file:
if lib.hasSuffix ".nix" file
then pkgs.callPackage file {}
else pkgs.writeShellScriptBin (builtins.elemAt (builtins.match "^(.*)\\.[a-z]*$" (builtins.baseNameOf file)) 0)
                              (builtins.readFile file)


