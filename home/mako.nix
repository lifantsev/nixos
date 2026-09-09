{ rice, ... }: {
    services.mako = with rice.col; {
        enable = true;
        
        settings = {
            font = "monospace ${toString rice.font.code.size}";
            icons = false;
            actions = false;
            default-timeout = 7*1000; # millis
            ignore-timeout = false;
            layer = "overlay";
            anchor = "bottom-right";
            max-visible = -1;
            
            width = 300;
            height = 150;
            border-size = 1; # irrelevant b/c transparent color
            border-radius = rice.window.radius;
            
            margin = 0;
            outer-margin = rice.window.gaps-out + rice.window.gaps-in; # outside of total border
            padding = rice.window.gaps-in; # internal
            
            text-color       = "${fg.h}ff";
            background-color = "${bg.h}e6";

            progress-color   = "${blue.h}ff";
            border-color     = "${fg.h}00";
        };

        extraConfig = ''
            [category=time]
            width=60

            [category=volume]
            width=93

            [category=date]
            width=100

            [category=brightness]
            width=152

            [category=battery]
            width=190

            [urgency=critical]
            text-color=${red.h}ff

            [urgency=low]
            text-color=${yellow.h}ff
        '';
    };
}
