{ ... }: {
    # for gmmk pro keyboard, swap meta & alt (to match mac keyboard)
    services.keyd = {
        enable = true;
        keyboards.gmmk = {
            ids = [ "320f:5044" ];

            settings.main = {
                leftalt = "leftmeta";
                leftmeta = "leftalt";
            };
        };
    };
}

