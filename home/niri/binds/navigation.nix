{ ... }: {
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
        Right = "swap-window-right";

        SHIFT.Up = "move-workspace-up";
        SHIFT.Down = "move-workspace-down";

        L = "toggle-overview";
        Y = "maximize-column";
        C = "toggle-column-tabbed-display";

        SHIFT.Y = [ "set-column-width" "+5%" ];
        SHIFT.C = [ "set-column-width" "-5%" ];

        CTRL.Y = "move-workspace-to-monitor-up";
        CTRL.C = "move-workspace-to-monitor-down";

        Up = "focus-monitor-up";
        Down = "focus-monitor-down";

        Semicolon = "close-window";
    };
}
