{
    col = import ./colors/catppuccin.nix;

    font = {
        name = "VictorMono";
        size = 11.5;
        full = let family = "Victor Mono"; in {
            inherit family;
            bold = "${family} Bold";
            italic = "${family} Italic";
            bold-italic = "${family} Bold Italic";
        };
    };

    style = {
        rounding = false;
        animation = false;
    };

    bar = {
        fontsize = 18;
        height = 35;
    };

    window = let gaps = 5; in {
        border = 2;
        radius = 7;
        gaps-in = gaps;
        gaps-out = 2*gaps;
    };
}
