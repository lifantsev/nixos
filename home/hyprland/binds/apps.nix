{ config, dispatch, exec, submap, subreset,  ... }: let
    preselect = x: dispatch "layoutmsg preselect ${x}";
in {
    main = {
        L   = [ (preselect "l") (submap "apps") ];
        Tab = [ (preselect "u") (submap "apps") ];
        U   = [ (preselect "d") (submap "apps") ];
        Q   = [ (preselect "r") (submap "apps") ];

        P = exec "pass-autotype";
        SHIFT.P = exec "pass-autotype --interactive";

        Z = exec "screenshot";
        SHIFT.Z = exec "screenrecord";
    };

    # I have it set so these binds are made both w/ and w/o the SUPER mod
    # the intention is that on my upcoming custom keyboard i can have super as a oneshot key
    # so i hit <oneshot(super) 'q' 't'> and it works even though the 't' doesnt have a modifier applied
    # once i get the keyboard, see if it is practical this way, and decide if i want to keep or change this config
    apps = let
        term = config.home.sessionVariables.TERMINAL;
        browser = config.home.sessionVariables.BROWSER;
    in {
        Space = submap "reset";
        L = subreset (exec term+" launcher");

        T = subreset (exec term);
        H = subreset (exec browser);
        B = subreset (exec "brave");
    };
}
