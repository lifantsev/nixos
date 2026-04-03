{ exec, ... }: let
    setvol = "$XDG_CONFIG_HOME/hypr/sh/setvol.sh";
    setbright = "$XDG_CONFIG_HOME/hypr/sh/setbright.sh";
in {
    main.NONE = {
        XF86AudioRaiseVolume = exec "${setvol} 3%+ && barless volume 500";
        XF86AudioLowerVolume = exec "${setvol} 3%- && barless volume 500";
        XF86AudioMute        = exec "${setvol} mute && barless volume 500";

        XF86MonBrightnessUp   = exec "${setbright} 3%+ && barless brightness 500";
        XF86MonBrightnessDown = exec "${setbright} 3%- && barless brightness 500";

        # TODO install my plyr script, modernize it and then uncomment these
        # XF86AudioPlay = exec "plyr toggle";
        # XF86AudioNext = exec "plyr next";
        # XF86AudioPrev = exec "plyr prev";
    };
}
