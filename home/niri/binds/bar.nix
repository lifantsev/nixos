{ mode, sh, ... }: {
    default.W = mode "bar";

    bar = {
        D = sh "barless date";
        T = sh "barless time";
        B = sh "barless battery";
        V = sh "barless volume";
        M = sh "barless music";
    };
}
