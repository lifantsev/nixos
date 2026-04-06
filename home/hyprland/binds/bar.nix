{ exec, submap, subreset,  ... }: {
    main.W = submap "bar";

    bar = {
        Space = submap "reset";

        T = subreset (exec "barless time");
        D = subreset (exec "barless date");

        M = subreset (exec "barless music");
        B = subreset (exec "barless battery");
        V = subreset (exec "barless volume");
        I = subreset (exec "barless brightness");
    };
}
