{ config, rice, ... }@args: {
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
        syntaxHighlighting = {
            enable = true;
            styles = let
                mk = c: "fg=${rice.col.${c}.h}";
            in {
                comment = mk "mg";
                single-quoted-argument = "fg=green";
                double-quoted-argument = "fg=green";
                single-quoted-argument-unclosed = "fg=green";
                double-quoted-argument-unclosed = "fg=green";
            };
        };

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

        shellAliases = (import ./alias/git.nix) // (import ./alias/other.nix);

        initContent = /*bash*/ ''
            ${import ./function/xioxide.nix args}

            ${builtins.readFile ./function/download.sh}
            ${builtins.readFile ./function/extract.sh}

            ${builtins.readFile ./bind/binds.zsh}
            ${builtins.readFile ./bind/lazy-comp-init.zsh}

            source $ZDOTDIR/plugins/nix-shell.plugin.zsh

            setopt INTERACTIVE_COMMENTS # allow comments on cmdline

            # startup command
            ${config.programs.zsh.shellAliases.n}
        '';
    };

    programs.starship.enableZshIntegration = true;
    programs.starship = {
        enable = true;
        settings = let
            dir       = "blue italic";
            nixshell  = "green italic";
            gitremote = "purple";
            gitstage  = "red bold";
        in {
            add_newline = true;
            format = "$git_status$env_var$directory";

            env_var = {
                variable = "IN_NIX_SHELL";
                format = "[nix](${nixshell}) ";
            };

            directory = {
                truncation_length = 0;
                truncate_to_repo = true;

                format = "[$path](${dir}) ";
            };

            git_status = {
                format = "[$ahead_behind](${gitremote})[$all_status](${gitstage})";

                up_to_date = "-> ";
                ahead      = ">> ";
                behind     = "<< ";
                conflicted = ">< ";
                diverged   = ">< ";

                untracked = "nw ";
                stashed   = "$$ ";
                modified  = "ch ";
                staged    = "gc ";
                renamed   = "mv ";
                deleted   = "rm ";
            };
        };
    };
}
