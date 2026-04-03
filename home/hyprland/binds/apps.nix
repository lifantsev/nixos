{ dispatch, exec, submap, subreset,  ... }: let
    preselect = x: dispatch "layoutmsg preselect ${x}";
in {
    main = {
        L   = [ (preselect "l") (submap "apps") ];
        Tab = [ (preselect "u") (submap "apps") ];
        U   = [ (preselect "d") (submap "apps") ];
        Q   = [ (preselect "r") (submap "apps") ];

        P = exec "pw";
        SHIFT.P = exec "pw --interactive";

        Z = exec "screenshot";
    };

    # I have it set so these binds are made both w/ and w/o the SUPER mod
    # the intention is that on my upcoming custom keyboard i can have super as a oneshot key
    # so i hit <oneshot(super) 'q' 't'> and it works even though the 't' doesnt have a modifier applied
    # once i get the keyboard, see if it is practical this way, and decide if i want to keep or change this config
    apps =  {
        Space = submap "reset";
        T = subreset (exec "kitty");
        H = subreset (exec "browser new-window");
        B = subreset (exec "brave");
    };
}
