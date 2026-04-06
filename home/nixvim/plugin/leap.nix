{ rice, ... }: with rice.col; {
    plugin.enable = true;

    remap = let modes = [ "n" "x" "o" ]; in [
        { mode = modes; key = "<tab>"; action = "<Plug>(leap)"; }
        { mode = modes; key = "<s-tab>"; action = "<Plug>(leap-anywhere)"; }
    ];
}
