{ pkgs, lib, rice, ... } : {
    programs.obsidian = {
        enable = true;

        vaults.default.target = "obsidian";

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

            mkpkg = f: { pkg = pkgs.callPackage f {}; };
        in {
            themes = [( mkpkg ./themes/${rice.col.name}.nix )];
            communityPlugins = map mkpkg (filesIn ./plugins);
        });
    };


}

