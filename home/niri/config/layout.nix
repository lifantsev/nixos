{ rice, quot, ... }: {
    layout = {
        gaps = rice.window.gaps;

        center-focused-column = quot "never";

        default-column-width.proportion = 0.5;

        focus-ring.enable = false;

        border = {
            enable = true;
            width = rice.window.border;
        };
    };
}

