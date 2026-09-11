{ spawn, sh, ... }: {
    default = {
        T = spawn "kitty";
        SHIFT.T = sh "wtype -M ctrl -M alt -M shift -k t -m shift -m alt -m ctrl"; # kitty spawn window with same cwd

        H = spawn "zen-beta";
        B = spawn "obsidian";

        Z = spawn "screenshot";
        SHIFT.Z = spawn "screenrecord";

        P = spawn "pass-autotype";
        SHIFT.P = sh "pass-autotype --interactive";

        Space = sh "makoctl dismiss -a";
    };
}
