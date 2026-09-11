{ lib, ... }@args: with builtins; let
    recursiveMergeAttrsList = lib.lists.foldr (a: b: lib.recursiveUpdate a b) {};

    # `a` is the attrset passed in by niri-bind-modes
    # we add one entry for convenience, so `a'` has `mode`, `sh`, and `spawn`
    r = a: let a' = a // { spawn = n: [ "spawn" n ]; }; in
        readDir ./.
        |> attrNames
        |> filter (name: name != "default.nix")
        |> map (name: ./. + "/${name}")
        # some portions of the bindings need args like `pkgs` for custom script
        # we differentiate between them by making the ones that need `args` an attrset
        |> map (file: let
            val = import file;
        in if typeOf val == "set" then
            val.func args a'
        else val a')
        |> recursiveMergeAttrsList;
in r
