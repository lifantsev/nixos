# paths
{ lib, config, mkBindFile, ... }: {
    current = "pwd";

    sed = ''
    s/^h/nh/
    s/^o/xs/
    '';

    binds = let
        home = config.home.homeDirectory;
        mkBinds = len: path: lib.mapAttrs' (name: x: lib.nameValuePair (builtins.substring 0 len name) name)
                                           (lib.attrsets.filterAttrs (n: v: v == "regular" && n != "default.nix") 
                                           (builtins.readDir path));
    in with config.xdg.userDirs;
    mkBindFile {
        m = "mnt/";

        d = download+"/";
        v."${videos}/".p = "playlists/";
        p."${pictures}/".s = "screenshot/";

        s."${config.programs.password-store.settings.PASSWORD_STORE_DIR}/".m = ".map";

        x."${documents}/" = {
            t."todo/" = {
                o = "school.md";
                l = "linux.md";
            };
            s."school/1-3-freshman-spring/" = {
                c = "cs-33/";
                m = "math-115a/";
                p = "phys-1b/";
                h = "philos-31/";
            };
        };

        r."${extraConfig.XDG_REPOSITORY_DIR}/" = {
            p."pw/" = {
                m = "main.sh";
                r = "README.md";
            };
        };

        n."${home}/nixos/" = let
            d = "default.nix";
        in {
            f = "flake.nix";

            r."rice/" = {
                inherit d;
                c = "colors/src/";
            };

            h."home/" = mkBinds 2 ../.. //
                {
                    inherit d;

                y."hyprland/" = {
                    inherit d;
                    b = "binds/";
                    s = "sh/";
                };

                l."lf/" = {
                    inherit d;
                    b = "binds.nix";
                    o = "options.nix";
                };

                v."nixvim/" = {
                    inherit d;
                    o = "options.nix";
                    b = "binds/";
                    p = "plugin/";
                };

                q."qutebrowser/" = {
                    inherit d;
                    b = "binds.nix";
                    o = "options.nix";
                    c = "colors.nix";
                    s = "userscripts/";
                    u = "userstyles/";
                };

                s."spotify-player/" = {
                    inherit d;
                    b = "binds.nix";
                    o = "options.nix";
                    c = "colors.nix";
                };

                x."xioxide/" = {
                    inherit d;
                    p = "configs/paths.nix";
                    s = "configs/sites.nix";
                };
                
                z."zsh/" = {
                    inherit d;
                    f = "function/";
                    a = "alias/";
                    b = "bind/";
                };
            };

            c."config/" = {
                inherit d;
                p = "pkgs.nix";

                c."custom-apps/" = mkBinds 1 ../../../config/custom-apps;
                s."custom-scripts/" = mkBinds 1 ../../../config/custom-scripts;
            };
        };
    };
}
