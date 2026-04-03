{ lib, ... }: let
    dispatch  = x: "hyprctl dispatch ${x}";
    exec      = x: dispatch "exec '${x}'";
    submap    = x: dispatch "submap ${x}";
    subreset  = cmd: cmd + " && " + submap "reset";

    args = { inherit dispatch exec submap subreset; };

    # takes a bigbindset: keys are either:
    # <keystr> : then value is a cmdlist/str
    # <modname> : then value is a bindset (see below)
    # returns a list of hyprland bind strings
    fullBindList = bigbindset: let
        isMod = k: builtins.elem k [ "SHIFT" "CTRL" "CTRL SHIFT" "SHIFT CTRL" ];
        cleanbindset = { "SUPER" = lib.filterAttrs (k: v: ! isMod k && k != "NONE") bigbindset; }
                    // lib.mapAttrs' (k: v: lib.nameValuePair ("SUPER " + k) v) (lib.filterAttrs (k: v: isMod k) bigbindset)
                    // lib.mapAttrs' (k: v: lib.nameValuePair "" v) (lib.filterAttrs (k: v: k == "NONE") bigbindset);
    in lib.concatLists (lib.attrsets.mapAttrsToList bindList cleanbindset);

    # takes a modstr (or a list of them) and a bindset (key: keyname | val: cmdlist/str)
    # returns a list of hyprland bind strings
    bindList = modstr: bindset: let
        modstrlist = if builtins.typeOf modstr == "list" then modstr else [ modstr ];
    in lib.concatLists (map (modstr: lib.attrsets.mapAttrsToList (keystr: cmds: bindStr modstr keystr cmds) bindset) modstrlist);

    # takes a modstr, keystr, and list of cmds (or str)
    # returns a valid hyprland bind string to create that binding
    bindStr = modstr: keystr: cmds: "${modstr}, ${keystr}, exec, ${execStr cmds}";

    # takes either list of bash cmds or one bash cmd in a string
    # returns one string that executes all passed cmds
    execStr = cmds: if builtins.typeOf cmds == "list"
                    then lib.strings.concatStrings (map (v: v + " && ") cmds) + "true"
                    else cmds;

    bindFiles = let fileset = lib.attrsets.filterAttrs (n: v: v == "regular") (builtins.readDir ./binds);
                in map (name: ./binds + "/${name}") (builtins.attrNames fileset);

    recursiveMergeAttrsList = lib.lists.foldr (a: b: lib.recursiveUpdate a b) {};
in {
    bind = fullBindList (recursiveMergeAttrsList (map (file: (import file args).main or {}) bindFiles));

    submaps = let submapAttrs = recursiveMergeAttrsList (map (file: lib.filterAttrs (k: v: k != "main") (import file args)) bindFiles);
              in lib.mapAttrs (k: bindset: bindList [ "SUPER" "" ] bindset) submapAttrs;

}
