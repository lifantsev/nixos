{ ... }@args: let
    entriesIn = path: map (name: path + "/${name}") (builtins.attrNames (builtins.readDir path));

    paths = (entriesIn ./apps ++ entriesIn ./scripts);
    enabledPaths = builtins.filter (path: ! builtins.pathExists (path + "/disable")) paths;
in map (import ./import.nix args) enabledPaths

