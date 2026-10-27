# sites
{  mkBindFile, ... }: {
    binds = let
        googleusers = {
            a = "u/0/"; # auto / mark lif
            s = "u/1/"; # school
            m = "u/2/"; # mrktix
            b = "u/3/"; # bruinai
        };
    in mkBindFile
    {
        nx."mynixos.com/".s = "search?q=";
        ng."noogle.dev/".s = "q?term=";

        "in"."linkedin.com/".s = "search/results/all/?keywords=";
        sl = "app.slack.com/client/";
        di = "discord.com/channels/@me";
        me = "web.groupme.com/";

        gh."github.com/" = {
            s = "search?q=";
            n = "lifantsev/nixos/";
            p = "lifantsev/pass-autotype/";
        };

        u = "my.ucla.edu/";
        o."bruinlearn.ucla.edu/courses/" = {
            c = "235524/"; # 35l
            m = "235522/"; # m51a
            p = "238538/"; # 1c
            l = "238494/"; # 4al
        };

        gm."mail.google.com/mail/" = googleusers;
        gd."docs.google.com/document/" = googleusers;
        gs."docs.google.com/spreadsheets/" = googleusers;
        gp."docs.google.com/presentation/" = googleusers;
        gc."calendar.google.com/" = googleusers;
        gt."tasks.google.com/" = googleusers;
        gv."drive.google.com/drive/" = googleusers;
        gg."gemini.google.com/" = googleusers;

        ibkr = "portal.interactivebrokers.com/";
        cap = "verified.capitalone.com/auth/signin/";

        y."youtube.com/".s = "results?q=";
        ig = "instagram.com/direct/inbox/";
    };
}

