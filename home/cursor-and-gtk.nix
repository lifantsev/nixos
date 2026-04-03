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

        # sway.enable = true;
        # x11.enable = true;
        # x11.defaultCursor = cursor.name;
    };


    gtk = {
        enable = true;

        colorScheme = "dark";
        theme = {
            # name = "catppuccin-mocha-mauve-standard+default";
            # package = pkgs.catppuccin-gtk;

            name = rice.col.gtk-name;
            package = pkgs.${rice.col.gtk-package};
        };

        font = {
            name = rice.fonts.code.full.family;
            size = rice.fonts.code.size;
        };

        cursorTheme = cursor;
    };
}
