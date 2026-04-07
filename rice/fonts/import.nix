size: path: let
    font = import path;
    italic = font.italic or "Italic";
    bold = font.italic or "Bold";
in font // {
    inherit size;

    full.family      = font.family;
    full.bold        = font.family + bold;
    full.italic      = font.family + italic;
    full.bold-italic = font.family + bold + italic;
}
