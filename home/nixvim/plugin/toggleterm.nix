{ ... }: {
    plugin.enable = true;

    remap = let act = dir: "<CMD>lua toggletermdir='${dir}'<CR><CMD>ToggleTerm direction=${dir}<CR>"; in [
        { mode = "n"; key = "<c-l><down>";  action = act "horizontal"; }
        { mode = "n"; key = "<c-l><right>"; action = act "vertical"; }
        { mode = "n"; key = "<c-l><up>";    action = act "float"; }

        { mode = "n"; key = "<c-l><c-i>"; action = act "horizontal"; }
        { mode = "n"; key = "<c-l><c-o>"; action = act "vertical"; }
        { mode = "n"; key = "<c-l><c-a>"; action = act "float"; }

        { mode = "t"; key = ";n"; action = "<CMD>ToggleTerm<CR>"; }
        { mode = "t"; key = ";a"; action.__raw = ''function()
            if toggletermdir == "horizontal" then
                vim.cmd("wincmd k")
            elseif toggletermdir == "vertical" then
                vim.cmd("wincmd h")
            elseif toggletermdir == "float" then
                vim.cmd("ToggleTerm")
            end
        end''; }
    ];

    plugin.settings = {
        shell.__raw = "vim.o.shell";
        hide_numbers = true;
        shade_terminals = false;
        start_in_insert = true;
        persist_size = true;
        close_on_exit = true;
        autochdir = true;

        highlights.FloatBorder.link = "FloatBorder";

        float_opts = {
            border = "single";
            winblend = 0;
            width.__raw = "function() return math.floor(vim.o.columns * 0.8) end";
            height.__raw = "function() return math.floor(vim.o.lines * 0.8) end";
        };

        size.__raw = ''function(term)
            if term.direction == "horizontal" then
                return vim.o.lines*0.3
            elseif term.direction == "vertical" then
                return vim.o.columns*0.35
            end
        end'';
    };
}
