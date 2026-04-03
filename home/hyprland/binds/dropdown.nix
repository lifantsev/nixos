{ exec, submap, subreset, ... }: {
    main.Period = submap "dropdown";

    dropdown = {
        Space = submap "reset";

        W = subreset (exec "drop");

        T = subreset (exec "drop term");
        N = subreset (exec "drop nixbuild");
        Q = subreset (exec "drop qalc");
        S = subreset (exec "drop spotify");
    };
}
