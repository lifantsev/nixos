{ rice, ... }: with rice.col; {
    plugin.enable = true;

    lua = /*lua*/ ''
        vim.api.nvim_set_hl(0, 'LeapLabel', { fg = '${purple.h}', 
                                              bg = '${t0.h}',
                                              bold = true })
    '';

    remap = let modes = [ "n" "x" "o" ]; in [
        { mode = modes; key = "<tab>"; action = "<Plug>(leap)"; }
        { mode = modes; key = "<s-tab>"; action = "<Plug>(leap-anywhere)"; }
    ];
}
