{ rice, ... }: {
    prefer-no-csd = true; # disable annoying decoration

    animations.slowdown = 0.5;

    layout = {
        gaps = rice.window.gaps;

        center-focused-column = "never";

        default-column-width.proportion = 0.5;

        focus-ring.enable = false;

        border = {
            enable = true;
            width = rice.window.border;
        };
    };
}

