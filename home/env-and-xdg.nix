{ pkgs, config, ... }: {
    home.sessionVariables = {
        VISUAL = "nvim";
        EDITOR = "nvim";
        BROWSER = "zen-beta";
        DEFAULT_BROWSER = "${config.home.sessionVariables.BROWSER}";
        TERMINAL = "kitty";
        NIX_BUILD_SHELL = "zsh";
        DMENU_PROGRAM = "dropmenu";
        MANPAGER = "nvimpager";

        EDITORS = "nvim";
        BROWSERS = "firefox\nbrave-browser\norg.qutebrowser.qutebrowser\nzen-beta";
        TERMINALS = "kitty";
    };

    xdg = let home = config.home.homeDirectory; in
        {
        enable = true;

        configHome = "${home}/.config";
        dataHome = "${home}/.local/share";
        stateHome = "${home}/.local/state";
        cacheHome = "${home}/.local/cache";

        desktopEntries.zen-beta = {
            name = "zen-beta";
            exec = "${pkgs.zen-beta}/bin/zen-beta";
        };

        mimeApps.enable = true;
        mimeApps.defaultApplications = let
            zen = "${config.home.sessionVariables.BROWSER}.desktop";
        in {
            "text/html" = zen;
            "x-scheme-handler/http" = zen;
            "x-scheme-handler/https" = zen;
            "x-scheme-handler/about" = zen;
            "x-scheme-handler/unknown" = zen;
        };

        userDirs = {
            enable = true;
            createDirectories = false;
            setSessionVariables = true;

            download = "${home}/dl";
            music = "${home}/mus";
            videos = "${home}/vid";
            pictures = "${home}/pix";
            documents = "${home}/dox";

            publicShare = "${home}/.local/public";
            desktop = "${home}/public/desktop";
            templates = "${home}/.local/public/templates";

            extraConfig = {
                REPOSITORY = "${home}/repos";
            };
        };
    };
}
