{ rice, ... }@args: { programs = {
    dropmenu = {
        enable = true;
        integrations.niridrop = true; # register dropmenu-ui window
        showhide = "niridrop";
    };

    pinentry-dropdown = {
        enable = true;
        integrations.niridrop = true; # register getpin-ui window
        showhide = "niridrop";
    };

    niri = {
        bind-modes = {
            enableBindsFile = true;
            enableConfigFile = true;

            defaultModifiers = [ "MOD" ];

            binds = import ./binds args;
            extraConfig = import ./config args;
        };

        niridrop = {
            enableJSON = true;
            enableKDL = true;
            bindModesIntegration = true; # piggyback off bind-modes.extraConfig to include dropdown.kdl

            windows = import ./dropdowns.nix args;
        };
    };
};}
