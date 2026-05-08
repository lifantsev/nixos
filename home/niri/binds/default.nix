{ lib, ... }: with builtins; let
    recursiveMergeAttrsList = lib.lists.foldr (a: b: lib.recursiveUpdate a b) {};

    r = a: let a' = a // { spawn = n: [ "spawn" n]; }; in 
        readDir ./.
        |> attrNames
        |> filter (n: n != "default.nix")
        |> map (n: ./. + "/${n}")
        |> map (f: import f a')
        |> recursiveMergeAttrsList;
in r
