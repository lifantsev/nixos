{ submap, subreset, dispatch, ... }: {
    main.Semicolon = submap "exit";

    exit =  {
        Space = submap "reset";
        N = subreset (dispatch "killactive");
    };
}
