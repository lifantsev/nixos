{ ... }@args: {
    programs.niri = {
        extraConfig = builtins.readFile ./config.kdl;
        bind = {
            defaultModifiers = [ "MOD" ];
            set = import ./binds.nix;
        };
    };
}

