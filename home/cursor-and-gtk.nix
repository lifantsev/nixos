{ pkgs, rice, ... }: let
    cursor = {
        size = 24;
        name = "apple-cursor";

        package = pkgs.runCommand "moveUp" {} ''
            mkdir -p $out/share/icons
            ln -s ${pkgs.fetchzip {
                stripRoot = false;
                url = "https://github.com/ful1e5/apple_cursor/releases/download/v2.0.1/macOS.tar.xz";
                hash = "sha256-nS4g+VwM+4q/S1ODb3ySi2SBk7Ha8vF8d9XpP5cEkok=";
            }}/macOS $out/share/icons/apple-cursor
        '';
    };
in {
    home.pointerCursor = cursor // {
        enable = true;
        hyprcursor.enable = true;
        gtk.enable = true; 
        x11.enable = true;
    };

    dconf.settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";

    gtk = let
        theme = {
            name = rice.col.gtk-name;
            package = pkgs.${rice.col.gtk-package};
        };
    in {
        inherit theme;
        gtk4.theme = theme;

        enable = true;
        colorScheme = "dark";

        cursorTheme = cursor;

        font = {
            name = rice.font.code.full.family;
            size = rice.font.code.size;
        };
    };
}
