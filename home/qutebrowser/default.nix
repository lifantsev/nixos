{ rice, ... }@args: {
    xdg.configFile = import ./userstyles.nix // { "qutebrowser/userscripts".source = ./userscripts; };

    home.sessionVariables.QT_QPA_PLATFORM = "wayland";

    programs.qutebrowser = {
        enable = false; # qutebrowser is now insecure :( 'Still accepts eMudhra TLS certs.'
        enableDefaultBindings = false;
        loadAutoconfig = true; # allow settings changes inside the app

        extraConfig = (import ./options.nix).extraConfig;
        settings = (import ./options.nix).settings // {
            colors = import ./colors.nix args;
        };
        
        keyBindings = import ./binds.nix args;

        aliases = {};
        quickmarks = {};

        searchEngines.DEFAULT = "https://www.google.com/search?q={}";
    };
}
