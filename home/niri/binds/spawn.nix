{ spawn, sh, ... }: {
    default = {
        T = spawn "kitty";
        H = spawn "qutebrowser";
        B = sh "brave --ozone-platform=wayland";

        Z = spawn "screenshot";
        SHIFT.Z = spawn "screenrecord";

        P = spawn "pass-autotype";
        SHIFT.P = sh "pass-autotype --interactive";
    };
}
