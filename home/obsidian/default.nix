{ pkgs, lib, rice, ... } : {
    programs.obsidian = {
        enable = true;

        vaults = lib.mergeAttrsList (map (n: { ${n}.target = "obsidian/${n}"; }) [
            "stem"
            "hum"
            "projects"
        ]);

        defaultSettings = {
            app = {
                showInlineTitle = true;
                promptDelete = false;
                alwaysUpdateLinks = true;
                spellcheck = false;
                attachmentFolderPath = "./";
                newFileLocation = "current";
                vimMode = true;
            };

            appearance = {
                theme = "obsidian"; # dark mode
                showViewHeader = true;
                nativeMenus = false;
                showRibbon = true;
                baseFontSize = 17;
            };
        } // (let 
            filesIn = path: let
                fileset = lib.attrsets.filterAttrs (n: v: v == "regular") (builtins.readDir path);
            in map (name: path + "/${name}") (builtins.attrNames fileset);

            mkPackages = flist: map (f: { pkg = pkgs.callPackage f {}; }) flist;
        in {
            themes = mkPackages [(./themes + "/${rice.col.name}.nix")];
            communityPlugins = mkPackages (filesIn ./plugins);
        });
    };


}

