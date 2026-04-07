{
    name = "TimesNewerRoman";
    package = "times-newer-roman";
    size = 12;
    full = let family = "Times Newer Roman";
    in {
        inherit family;
        bold        = "${family} Bold";
        italic      = "${family} Italic";
        bold-italic = "${family} Bold Italic";
    };
}
