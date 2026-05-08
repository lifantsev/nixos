{ rice, ... }: with rice.col; {
    overview.backdrop-color = black.h;

    layout = {
        background-color = black.h;

        border = let
            grad = from: to: {
                inherit from to;
                angle = 45;
                relative-to = "window";
                in' = "oklch shorter hue";
            };
        in {
            active.gradient = grad blue.h purple.h;
            inactive.gradient = grad t1.h t2.h;
            urgent.gradient = grad red.h orange.h;
        };
    };
}
