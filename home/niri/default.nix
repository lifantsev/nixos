{ ... }: {
    programs.dropmenu = {
        enable = true;
        integrations.niridrop = true; # register niridrop window
        dropdownProgram.niri = "niridrop";
    };

    # programs.pinentry-niridrop = {
    #     enable = true;
    # };

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

                getpin-ui = {
                    app_id = "getpin-ui";
                    cmd = "kitty --class getpin-ui getpin-ui";
                    size = [ 0.3 0.16 ];
                };
            };
        };
    };
}
