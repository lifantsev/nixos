{ rice, quot, ... }: with rice.col; let  in {
    overview.backdrop-color = quot black.h;
    layout = {
        background-color = quot black.h;

        border = let
            grad = from: to: ''from="${from}" to="${to}" angle=45 relative-to="workspace-view" in="oklch shorter hue"'';
        in {
            active-gradient = grad blue.h purple.h;
            inactive-gradient = grad t1.h t2.h;
            urgent-color = quot red.h;
        };
    };
}
