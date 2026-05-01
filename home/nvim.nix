{ rice, lib, ... }: {
    programs.lifantsev-nixvim = {
        enable = true;
        colorscheme = rice.col.name;
        colors = lib.mapAttrs (color: attrs: attrs.h) # extract hex code
                (lib.filterAttrs (k: v: builtins.typeOf v == "attrs") rice.col); # filter out metadata

        keys = {
            swap-rd = true;
            directional = {
                left  = "n";
                up    = "a";
                down  = "i";
                right = "o";
            };
            hjkl = {
                h = "i";
                j = "n";
                k = "a";
                l = "o";
            };
        };
    };
}
