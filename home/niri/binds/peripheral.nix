{ sh, ... }: {
    default.NONE = {
        # TODO remove from config.kdl when set up
        XF86AudioRaiseVolume = sh "echo";
        XF86AudioLowerVolume = sh "echo";
        XF86AudioMute = sh "echo";

        XF86MonBrightnessUp   = sh "brightnessctl -e3 set 3%+";
        XF86MonBrightnessDown = sh "brightnessctl -e3 set 3%-";
    };
}
