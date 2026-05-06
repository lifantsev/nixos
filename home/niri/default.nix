{ ... }: {
    programs.dropmenu = {
        enable = true;
        integrations.niridrop = true; # register dropmenu-ui window
        showhide = "niridrop";
    };

    programs.pinentry-dropdown = {
        enable = true;
        integrations.niridrop = true; # register getpin-ui window
        showhide = "niridrop";
    };

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
            bindModesIntegration = true; # piggyback off bind-modes.extraConfig to include dropdown.kdl

            windows = {
                term = {
                    app_id = "dropdown-term";
                    cmd = "kitty --class dropdown-term";
                };

                qalc = {
                    app_id = "dropdown-qalc";
                    cmd = "kitty --class dropdown-qalc qalc";
                };
            };
        };
    };
}
