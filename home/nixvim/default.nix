# TODO set up cmp and luasnip (completion in general)
# TODO set up DAP
# TODO set up lsp keybinds: goto def, list ref, etc
# TODO look into plugin for building project using vim bind (or write it)

{ lib, pkgs, rice, ... }@args: let
    stemOf = file: let
        matches = builtins.match "^(.*)\\.[a-z]*$" (builtins.baseNameOf file);
    in if matches == null then builtins.baseNameOf file else builtins.elemAt matches 0;

    filesIn = path: let
        fileset = lib.attrsets.filterAttrs (n: v: v == "regular") (builtins.readDir path);
    in map (name: path + "/${name}") (builtins.attrNames fileset);
in {
    programs.nixvim = {
        enable = true;

        opts = (import ./options.nix);
        globals.mapleader = " ";
        globals.loaded_matchit = 1; # disable loading of an annoying plugin

        colorschemes.${rice.col.name} = {
            enable = true;
            settings = {
                transparent_background = true;
                float.transparent = true;
                custom_highlights = with rice.col; {
                    FloatTitle = { fg = blue.h; };
                };
            };
        };
        plugins = lib.mergeAttrsList (map (file: { ${stemOf file} = (import file args).plugin;}) (filesIn ./plugin));
        extraPlugins = map (file: pkgs.vimPlugins.${stemOf file}) (filesIn ./plugin/extra);

        keymaps = lib.lists.concatLists ( (map (file: import file args) (filesIn ./remap)) 
                                       ++ (map (file: (import file args).remap or []) (filesIn ./plugin))
                                       ++ (map (file: if lib.hasSuffix ".nix" file then (import file args).remap or [] else []) (filesIn ./plugin/extra)) );

        extraConfigLuaPre = lib.concatStrings (map (file: if lib.hasSuffix ".nix" file then (import file args).lua else builtins.readFile file) (filesIn ./plugin/extra))
                          + lib.concatStrings (map (file: (import file args).lua or "") (filesIn ./plugin))
                          + lib.concatStrings (map builtins.readFile (filesIn ./extralua));
    };
}
