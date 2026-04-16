{ rice, lib, ... }: {
    programs.lifantsev-nixvim = {
        enable = true;
        colorscheme = rice.col.name;
        colors = lib.mapAttrs (color: attrs: attrs.h) # extract hex code
                (lib.filterAttrs (k: v: builtins.typeOf v == "attrs") rice.col); # filter out metadata
    };
}
