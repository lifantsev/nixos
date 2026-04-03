# sites
{  mkBindFile, ... }: {
    binds = let
        googleusers = {
            a = "u/0/";
            s = "u/1/";
            m = "u/2/";
        };
    in mkBindFile
    {
        nx."mynixos.com/".s = "search?q=";
        ng."noogle.dev/".s = "q?term=";

        gh."github.com/" = {
            s = "search?q=";
            n = "lifantsev/nixos/";
            p = "lifantsev/pw/";
        };

        ibkr = "portal.interactivebrokers.com/";
        cap = "verified.capitalone.com/auth/signin/";

        u = "my.ucla.edu/";
        o."bruinlearn.ucla.edu/courses/" = {
            c = "227811/";
            m = "233028/";
            p = "TODO";
            h = "231956/";
        };

        y."youtube.com/".s = "results?q=";
        ig = "instagram.com/direct/inbox/";

        gm."mail.google.com/mail/" = googleusers;
        gd."docs.google.com/document/" = googleusers;
        gs."docs.google.com/spreadsheets/" = googleusers;
        gp."docs.google.com/presentation/" = googleusers;
        gc."calendar.google.com/" = googleusers;
        gv."drive.google.com/drive/" = googleusers;
        gg."gemini.google.com/" = googleusers;
    };
}

