{
    # save screen space
    # showtabline is set in lualine.nix
    showmode = false;
    cmdheight = 0;

    # disable mouse
    mouse = "";

    # use system clipboard (wl-copy)
    clipboard = "unnamed,unnamedplus";

    # tab settings
    smartindent = true;
    autoindent = true;
    tabstop = 4;
    softtabstop = 4;
    shiftwidth = 4;
    expandtab = true;
    breakindent = true;
    linebreak = true;


    # searching settings
    ignorecase = true;
    smartcase = true;
    incsearch = true;
    hlsearch = false;

    # undo history
    swapfile = false;
    backup = false;
    undofile = true;

    # scrolloff
    scrolloff = 7;
    sidescrolloff = 3;

    # other
    laststatus = 3;
    termguicolors = true;
    wrap = false;
    report = 1000;
    guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175";
    colorcolumn = "0";
    timeoutlen = 700;
}
