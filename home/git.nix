{ pkgs, ... }: {
    programs.git = {
        enable = true;
        settings = {
            user.name = "Mark Lifantsev";
            user.email = "mark.lifantsev@gmail.com";
            user.signingkey = "0x8C0EDE730F3B6A1D";

            init.defaultBranch = "main";
            commit.gpgsign = true;
            tag.forceSignAnnotated = true;

            # update gpg tty so that gpg-agent binds pinentry to correct term
            core.sshCommand = "${pkgs.gnupg}/bin/gpg-connect-agent updatestartuptty /bye >/dev/null 2>&1; ssh";
        };
    };
    

    programs.diff-so-fancy = {
        enable = true;
        enableGitIntegration = true;

        pagerOpts = [ "--tabs=4" "-R" "-F" ];

        settings = {
            useUnicodeRuler = true;
            markEmptyLines = false;
        };
    };
}
