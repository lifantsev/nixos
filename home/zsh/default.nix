{ config, ... }@args: {
    # NOTE default shell is set in config/default.nix @ users.users.<username>.shell

    programs.kitty.shellIntegration.enableZshIntegration = true;
    programs.fzf.enableZshIntegration = true;
    services.gpg-agent.enableZshIntegration = true;

    # TODO look through autosuggest strategies
    # TODO look through syntax highlighting styles

    xdg.configFile."zsh/plugins" = {
        source = ./plugin;
        recursive = true;
    };

    programs.zsh = {
        enable = true;
        dotDir = "${config.home.homeDirectory}/.config/zsh";

        enableCompletion = false;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;

        sessionVariables = {
            ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE = "fg=7";
        };
        
        history = {
            path = "$ZDOTDIR/.zsh_history";
            size = 10000;
            save = 10000;
            extended = true;
            share = true; # shared hist between files
        };

        shellAliases = (import ./alias/git.nix) //
                       (import ./alias/other.nix) // {
            xioxide="source ${config.home.homeDirectory}/repos/xioxide/main.sh";
        };

        initContent = /*bash*/ ''
            ${import ./function/xioxide.nix args}
            ${import ./function/download.nix}
            ${import ./function/extract.nix}

            ${builtins.readFile ./bind/binds.zsh}
            ${builtins.readFile ./bind/lazy-comp-init.zsh}

            source $ZDOTDIR/plugins/nix-shell.plugin.zsh
        '';
    };

    programs.starship.enableZshIntegration = true;
    programs.starship = {
        enable = true;
        settings = let
            dirstyle      = "cyan italic";
            nixshellstyle = "red italic";
            gitstyle      = "blue";
            gitstylealt   = "yellow bold";
        in {
            add_newline = true;
            format = "$env_var$git_status$directory";

            env_var = {
                variable = "IN_NIX_SHELL";
                format = "[$env_value](${nixshellstyle}) ";
            };

            directory = {
                truncation_length = 0;
                truncate_to_repo = true;

                format = "[$path](${dirstyle}) ";
            };

            git_status = {
                format = "[$ahead_behind](${gitstyle})[$all_status](${gitstylealt}) ";

                up_to_date = "->";
                ahead      = ">>";
                behind     = "<<";
                conflicted = "><";
                diverged   = "><";

                untracked = " nw";
                stashed   = " $$";
                modified  = " ch";
                staged    = " gc";
                renamed   = " mv";
                deleted   = " rm";
            };
        };
    };
}
