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

                small = {
                    app_id = "dropdown-smallterm";
                    cmd = "kitty --class dropdown-smallterm";
                    size = [ 0.6 0.3 ];
                };

                qalc = {
                    app_id = "dropdown-qalc";
                    cmd = "kitty --class dropdown-qalc qalc";
                };
            };
        };
    };
}

