{ rice, ... }: {
    programs.mpv = {
        enable = true;
        bindings = {
            N = "add chapter -1";
            n = "seek -10";
            a = "seek -5";
            A = "frame-step -1";
            I = "frame-step 1";
            i = "seek +5";
            o = "seek +10";
            O = "add chapter 1";
            
            # shift L is loop
            l = "set speed 1";
            TAB = "add speed 0.1";
            u = "add speed -0.1";

            z = "screenshot"; # like super+z in my hypr conf

            m = "cycle audio";
            M = "cycle audio down";

            c = "cycle sub";
            C = "cycle sub down";
            "-" = "add sub-scale -0.1";
            "+" = "add sub-scale +0.1";
            "=" = "set sub-scale 1";
            SPACE = "cycle pause";

            ";" = "quit";
        };

        config = {
            no-keepaspect-window = true;
            osd-font = rice.fonts.read.name;
            sub-font = rice.fonts.read.name;
        };
    };
}

