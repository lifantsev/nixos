{ spawn, mode, sh, ... }: {
    default.Period = mode "dropdown";

    dropdown = let
        drop = name: sh "niridrop ${name}";
    in {
        W = spawn "niridrop";
        T = drop "term";
        S = drop "spotify";

        Q = drop "qalc";
        N = drop "nixbuild";
        M = drop "net";
        B = drop "blue";
    };
}
