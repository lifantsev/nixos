{ spawn, sh, ... }: {
    default = {
        T = spawn "kitty";
        SHIFT.T = sh "wtype -M ctrl -M alt -M shift -k t -m shift -m alt -m ctrl"; # kitty spawn window with same cwd

        H = spawn "qutebrowser";
        B = sh "brave --ozone-platform=wayland";
        X = spawn "zen-beta";

        Z = spawn "screenshot";
        SHIFT.Z = spawn "screenrecord";

        P = spawn "pass-autotype";
        SHIFT.P = sh "pass-autotype --interactive";
    };
}
