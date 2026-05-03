{ config, ... }: {
    home.sessionVariables = {
        VISUAL = "nvim";
        EDITOR = "nvim";
        BROWSER = "org.qutebrowser.qutebrowser";
        TERMINAL = "kitty";
        NIX_BUILD_SHELL = "zsh";
        DMENU_PROGRAM = "dropmenu";
        MANPAGER = "nvimpager";

        EDITORS = "nvim";
        BROWSERS = "firefox\nbrave-browser\norg.qutebrowser.qutebrowser";
        TERMINALS = "kitty";
    };

    xdg = let home = config.home.homeDirectory; in {
        enable = true;

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
    };
}
