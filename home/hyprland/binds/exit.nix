{ submap, subreset, dispatch, ... }: {
    main.Semicolon = submap "exit";

    # TODO rebind the power button key
    # NOTE it is already bound by something else

    exit =  {
        Space = submap "reset";
        N = subreset (dispatch "killactive");
    };
}
