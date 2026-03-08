{ pkgs, ... }: let
    cursor = {
        size = 24;
        name = "apple-cursor";
        # name = "apple_cursor";
        # package = pkgs.apple-cursor;
        # name = "Bibata-Modern-Ice";
        # package = pkgs.bibata-cursors;
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
        x11.enable = true;
        gtk.enable = true; 
        sway.enable = true;
        hyprcursor.enable = true;
        x11.defaultCursor = cursor.name;
    };

    gtk.enable = true;
    gtk.cursorTheme = cursor;
}
