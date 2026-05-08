{ ... }: {
    gestures.hot-corners.enable = false;

    input = {
        keyboard = {
            repeat-delay = 160;
            repeat-rate = 60;
        };

        warp-mouse-to-focus.enable = true;
        focus-follows-mouse.enable = true;

        touchpad = {
            tap = true;
            dwt = true;

            natural-scroll = false;
            accel-speed = 0.8;
            accel-profile = "flat";
            click-method = "button-areas";
        };
    };
}
