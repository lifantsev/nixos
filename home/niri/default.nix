{ pkgs, rice, ... }@args: { programs = {
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
        package = pkgs.niri;

        settings = import ./config args;

        bind-modes = {
            enable = true;
            defaultModifiers = [ "MOD" ];
            binds = import ./binds args;
        };

        niridrop = {
            enable = true;
            windows = import ./dropdowns.nix args;
        };
    };
};}
