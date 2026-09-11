{ func = { config, ... }: { spawn, sh, ... }: {
    default = let
        term = config.home.sessionVariables.TERMINAL;
        browser = config.home.sessionVariables.BROWSER;
    in {
        H = spawn browser;
        T = spawn term;
        SHIFT.T = sh "wtype -M ctrl -M alt -M shift -k t -m shift -m alt -m ctrl"; # kitty spawn window with same cwd

        B = spawn "obsidian";

        # utilities
        Z = spawn "screenshot";
        SHIFT.Z = spawn "screenrecord";

        P = spawn "pass-autotype";
        SHIFT.P = sh "pass-autotype --interactive";

        Space = sh "makoctl dismiss -a";
    };
};}
