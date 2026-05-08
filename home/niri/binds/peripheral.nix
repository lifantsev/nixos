{ sh, ... }: {
    default.NONE = {
        # TODO remove from config.kdl when set up
        XF86AudioRaiseVolume = sh "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1+ -l 1.0";
        XF86AudioLowerVolume = sh "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1-";
        XF86AudioMute = sh "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";

        XF86MonBrightnessUp   = sh "brightnessctl -e3 set 3%+";
        XF86MonBrightnessDown = sh "brightnessctl -e3 set 3%-";
    };
}
