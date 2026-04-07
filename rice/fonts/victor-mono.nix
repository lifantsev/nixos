{
    name = "VictorMono";
    package = "victor-mono";
    size = 11.5;
    full = let family = "Victor Mono";
    in {
        inherit family;
        bold = "${family} Bold";
        italic = "${family} Italic";
        bold-italic = "${family} Bold Italic";
    };
}
