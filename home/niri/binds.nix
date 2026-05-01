let
    mode = m: [m];
in {
    default = {
        N = "focus-column-left";
        A = "focus-window-or-workspace-up";
        I = "focus-window-or-workspace-down";
        O = "focus-column-right";

        SHIFT.N = "consume-or-expel-window-left";
        SHIFT.A = "move-window-up-or-to-workspace-up";
        SHIFT.I = "move-window-down-or-to-workspace-down";
        SHIFT.O = "consume-or-expel-window-right";

        Left  = "swap-window-left";
        Up    = "move-column-right";
        Down  = "move-column-left";
        Right = "swap-window-right";

        SHIFT.Up = "move-workspace-up";
        SHIFT.Down = "move-workspace-down";

        L = "toggle-overview";
        Y = "maximize-column";
        C = "toggle-column-tabbed-display";

        SHIFT.Y = [ "set-column-width" "+5%" ];
        SHIFT.C = [ "set-column-width" "-5%" ];

        CTRL.Y = [ "set-window-height" "+3%" ];
        CTRL.C = [ "set-window-height" "-3%" ];


        T = [ "spawn" "kitty" ];
        H = [ "spawn" "qutebrowser" ];

        Semicolon = "close-window";

        Period = mode "dropdown";

        NONE = {
            # TODO remove from config.kdl when set up
            XF86AudioRaiseVolume.sh = "echo";
            XF86AudioLowerVolume.sh = "echo";
            XF86AudioMute.sh = "echo";

            XF86MonBrightnessUp.sh   = "brightnessctl -e3 set 3%+";
            XF86MonBrightnessDown.sh = "brightnessctl -e3 set 3%-";
        };
    };

    dropdown = {
        W.sh = "niridrop";
        T.sh = "niridrop term";
    };
}
