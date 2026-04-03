{ rice, ... }: {
    services.mako = {
        enable = true;
        
        settings = with rice.col; {
            font = "monospace ${toString rice.fonts.code.size}";
            icons = false;
            actions = false;
            default-timeout = 7*1000; # millis
            ignore-timeout = false;
            layer = "overlay";
            anchor = "bottom-right";
            max-visible = -1;
            
            width = 300;
            height = 150;
            border-size = rice.window.border;
            border-radius = if rice.style.rounding then rice.window.radius else 0;
            
            margin = toString rice.window.gaps-out + ",0";
            outer-margin = 0;
            padding = toString rice.window.gaps-in;
            
            text-color = "${fg.h}ff";
            border-color = "${fg.h}b0";
            background-color = "${bg.h}b0";
            progress-color = "${blue.h}ff";
        };
    };
}
