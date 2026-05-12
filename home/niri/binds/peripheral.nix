{ sh, ... }: {
    default.NONE = {
        XF86AudioRaiseVolume = sh "wpctl set-volume @DEFAULT_AUDIO_SINK@ 3%+ -l 1.5 ; barless volume 500";
        XF86AudioLowerVolume = sh "wpctl set-volume @DEFAULT_AUDIO_SINK@ 3%- ; barless volume 500";
        XF86AudioMute = sh "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle ; barless volume 500";

        XF86MonBrightnessUp   = sh "brightnessctl -e3 set 3%+ ; sleep 0.01 ; barless brightness 500";
        XF86MonBrightnessDown = sh "brightnessctl -e3 set 3%- ; sleep 0.01 ; barless brightness 500";
    };
}
