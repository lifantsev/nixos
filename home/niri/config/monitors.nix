{ ... }: {
    # laptop: 3456 x 2160
    # monitor: 3840 x 2160

    # laptop: 1728 1080
    # monitor: 2560 1440
    outputs."HDMI-A-1" = {
        position.x = - (2560 - 1728) / 2;
        position.y = - 1440;
        scale = 1.5;
    };

    outputs."eDP-1" = {
        position.x = 0;
        position.y = 0;
        scale = 2;
    };
}

