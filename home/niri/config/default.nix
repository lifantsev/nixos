{ lib, ... }@args: with builtins; let
    recursiveMergeAttrsList = lib.lists.foldr (a: b: lib.recursiveUpdate a b) {};

    r = readDir ./.
        |> attrNames
        |> filter (n: n != "default.nix")
        |> map (n: ./. + "/${n}")
        |> map (f: import f args)
        |> recursiveMergeAttrsList;
in r
