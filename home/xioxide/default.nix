{ lib, config, ... }: let
    mkBindList = set: let
    in lib.concatLists (lib.mapAttrsToList
            (key: val: if builtins.typeOf val == "string" then [[ key val ]]
                       else let sublevel = builtins.elemAt (lib.mapAttrsToList (key: val: { k = key; v = val; }) val) 0;
                       in (map (bind: [ (key + (builtins.elemAt bind 0)) (sublevel.k + (builtins.elemAt bind 1))]) ([[ "" "" ]] ++ mkBindList sublevel.v)))
        set);

    mkBindFile = set: builtins.concatStringsSep "\n" (map (bind: builtins.concatStringsSep " " bind) (mkBindList set)) + "\n";

    args = { inherit lib config mkBindFile; };

    stemOf = file: let
        matches = builtins.match "^(.*)\\.[a-z]*$" (builtins.baseNameOf file);
    in if matches == null then builtins.baseNameOf file else builtins.elemAt matches 0;

    filesIn = path: let
        fileset = lib.attrsets.filterAttrs (n: v: v == "regular") (builtins.readDir path);
    in map (name: path + "/${name}") (builtins.attrNames fileset);
in {
    xdg.configFile = lib.mergeAttrsList ( map (file: lib.mapAttrs' (key: val: lib.nameValuePair "xioxide/${stemOf file}.${key}" { text = val; }) (import file args)) (filesIn ./configs));
}
