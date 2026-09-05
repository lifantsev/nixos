{ rice, lib, ... }: lib.recursiveUpdate {
    prefer-no-csd = true; # disable annoying decoration

    animations.slowdown = 0.5;

    layout = {
        center-focused-column = "never";
        default-column-width.proportion = 0.5;
    };

    overview.workspace-shadow = {
        offset = { x=0; y=0; };
        softness = 70;
        color = "#000000";
    };

    # move wallpaper into backdrop
    layout.background-color = "transparent";
    layer-rules = [{
        matches = [{ namespace = "^awww-daemon$"; }];
        place-within-backdrop = true;
    }];
} (let
    maximal = let
        shadow = {
            enable = true;
            softness = 12;
            spread = 0;
            offset = { x=0; y=0; };
            color = rice.col.blue.h + "FF";
        };
        geometry-corner-radius = let r = rice.window.radius * 1.0; in
            {
            top-left = r;
            top-right = r;
            bottom-left = r;
            bottom-right = r;
        };
    in {
        layout = {
            gaps = rice.window.gaps-in;
            struts = let g = rice.window.gaps-out - rice.window.gaps-in; in
                {
                left = g;
                right = g;
                top = g;
                bottom = g;
            };

            border.enable = false;
            focus-ring.enable = false;
        };

        layer-rules = [{
            matches = [{ namespace = "^notifications$"; }];
            inherit shadow geometry-corner-radius;
        }];

        window-rules = [
            { # highlight focused
                matches = [{ is-focused = true; }];
                inherit shadow;
            }
            { # round all corners
                inherit geometry-corner-radius;
                clip-to-geometry = true;
            }
        ];
    };

    minimal = { layout = {
        gaps = 0;

        focus-ring.enable = false;

        border = {
            enable = true;
            width = rice.window.border;
        };

    };};
in maximal)
