{ spawn, ... }: {
    default = {
        T = spawn "kitty";
        H = spawn "qutebrowser";

        Z = spawn "screenshot";
        SHIFT.Z = spawn "screenrecord";
    };
}
