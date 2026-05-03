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

                dropmenu-ui = {
                    app_id = "dropmenu-ui";
                    cmd = "kitty --class dropmenu-ui dropmenu-ui";
                };

                qalc = {
                    app_id = "dropdown-qalc";
                    cmd = "kitty --class dropdown-qalc qalc";
                };
            };
        };
    };
}

