{ ... }: {
    programs.niri = {
        bind-modes = {
            enableBindsFile = true;
            enableConfigFile = true;

            defaultModifiers = [ "MOD" ];
            binds = import ./binds.nix;

            extraConfig = builtins.readFile ./config.kdl;
        };

        niridrop = {
            enableJSON = true;
            enableKDL = true;
            bindModesIntegration = true;

            windows = {
                term = {
                    app_id = "dropdown-term";
                    cmd = "kitty --class dropdown-term";
                };

                menu-ui = {
                    app_id = "dropdown-menu-ui";
                    cmd = "kitty --class dropdown-menu-ui menu-ui";
                };

                qalc = {
                    app_id = "dropdown-qalc";
                    cmd = "kitty --class dropdown-qalc qalc";
                };
            };
        };
    };
}

