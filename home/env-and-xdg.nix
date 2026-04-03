{ config, ... }: {
    home.sessionVariables = {
        VISUAL = "nvim";
        EDITOR = "nvim";
        EDITORS = "nvim";
        BROWSER = "org.qutebrowser.qutebrowser";
        BROWSERS = "firefox\nbrave-browser\norg.qutebrowser.qutebrowser";
        TERMINAL = "kitty";
        TERMINALS = "kitty";
        DMENU_PROGRAM = "menu";
        NIX_BUILD_SHELL = "zsh";
        MANPAGER = "nvimpager";
    };

    # TODO go thru commented lines and see if i wanna uncomment
    xdg = let home = config.home.homeDirectory; in {
        enable = true;

        # mime.enable = true;

        configHome = "${home}/.config";
        dataHome = "${home}/.local/share";
        stateHome = "${home}/.local/state";
        cacheHome = "${home}/.local/cache";

        userDirs = {
            enable = true;
            createDirectories = false;

            download = "${home}/dl";
            music = "${home}/mus";
            videos = "${home}/vid";
            pictures = "${home}/pix";
            documents = "${home}/dox";

            publicShare = "${home}/.local/public";
            desktop = "${home}/public/desktop";
            templates = "${home}/.local/public/templates";

            extraConfig = {
                XDG_REPOSITORY_DIR = "${home}/repos";
            };
        };

        # mimeApps = {
        #     enable = true;
        #     defaultApplications = { # look in /run/current-system/sw/share/applications for .dekstop files
        #         "x-scheme-handler/http" = [ "${config.home.sessionVariables.BROWSER}.desktop" ];
        #         "x-scheme-handler/https" = [ "${config.home.sessionVariables.BROWSER}.desktop" ];
        #     };
        #     associations.removed = { # remove associations forced by some apps
        #         #"mimetype1" = "shittyapp.desktop";
        #     };
        # };
    };
}
