{ ...}:
{
    programs.git = {
        enable = true;
        settings = {
            user.name = "Mark Lifantsev";
            user.email = "mark.lifantsev@gmail.com";

            init.defaultBranch = "main";
            commit.gpgsign = true;
            tag.forceSignAnnotated = true;

            # gpg.format = "ssh";
            # user.signingkey = "${config.home.homeDirectory}/.ssh/id-github-canoe.pub";
        };
    };
    

    # programs.diff-so-fancy = {
    #     enable = true;
    #     enableGitIntegration = true;

    #     pagerOpts = [ "--tabs=4" "-R" "-F" ];

    #     settings = {
    #         useUnicodeRuler = true;
    #         markEmptyLines = false;

    #     };
    # };
}
