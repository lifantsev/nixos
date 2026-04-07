{ exec, submap, subreset, ... }: {
    main.Period = submap "dropdown";

    dropdown = {
        Space = submap "reset";

        W = subreset (exec "drop");

        T = subreset (exec "drop term");
        B = subreset (exec "drop blue");
        M = subreset (exec "drop net");
        N = subreset (exec "drop nixbuild");
        Q = subreset (exec "drop qalc");
        S = subreset (exec "drop spotify");
    };
}
