{ dispatch,  ... }: let
    focus   = x: dispatch "movefocus ${x}";
    resize  = x: dispatch "resizeactive ${x}";
    swapwin = x: dispatch "swapwindow ${x}";
    movewin = x: dispatch "movewindow ${x}";
in {
    main = {
        N = focus "l";
        A = focus "u";
        I = focus "d";
        O = focus "r";

        Left  = resize "-50 0";
        Right = resize "50 0";
        Up    = resize "0 -50";
        Down  = resize "0 50";

        M = dispatch "togglesplit";
        CTRL.M = dispatch "togglefloating";
        SHIFT.M = dispatch "fullscreen";

        SHIFT = {
            N = swapwin "l";
            A = swapwin "u";
            I = swapwin "d";
            O = swapwin "r";

            L   = movewin "l";
            Tab = movewin "u";
            U   = movewin "d";
            Q   = movewin "r";

            Left  = resize "-10 0";
            Right = resize "10 0";
            Up    = resize "0 -10";
            Down  = resize "0 10";
        };
    };
}
