{ ... }: {
    lua = /*lua*/ "require('winshift').setup()";

    remap = [
        { mode = "n"; key = "<leader>wn"; action = "<CMD>WinShift left<CR>"; }
        { mode = "n"; key = "<leader>wa"; action = "<CMD>WinShift up<CR>"; }
        { mode = "n"; key = "<leader>wi"; action = "<CMD>WinShift down<CR>"; }
        { mode = "n"; key = "<leader>wo"; action = "<CMD>WinShift right<CR>"; }
    ];
}
