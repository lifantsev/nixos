{ ... }: let modes = [ "n" "v" ]; in [
    # window nav
    { mode = modes; key = "<leader>n"; action = "<C-w><Left>"; }
    { mode = modes; key = "<leader>a"; action = "<C-w><Up>"; }
    { mode = modes; key = "<leader>i"; action = "<C-w><Down>"; }
    { mode = modes; key = "<leader>o"; action = "<C-w><Right>"; }

    # opening splits
    { mode = modes; key = "<leader>N"; action = "<CMD>set nosplitright<CR>:vsplit<CR>"; }
    { mode = modes; key = "<leader>A"; action = "<CMD>set nosplitbelow<CR>:split<CR>"; }
    { mode = modes; key = "<leader>I"; action = "<CMD>set splitbelow<CR>:split<CR>"; }
    { mode = modes; key = "<leader>O"; action = "<CMD>set splitright<CR>:vsplit<CR>"; }

    # tab nav
    { mode = "n"; key = ";t"; action = "<CMD>tab split<CR>"; }
    { mode = modes; key = "<leader>ts"; action = "<CMD>tab split<CR>"; }
    { mode = modes; key = "<leader>tn"; action = "<CMD>tabprev<CR>"; }
    { mode = modes; key = "<leader>ta"; action = "<CMD>tabmove +<CR>"; }
    { mode = modes; key = "<leader>ti"; action = "<CMD>tabmove -<CR>"; }
    { mode = modes; key = "<leader>to"; action = "<CMD>tabnext<CR>"; }
    
    # buffers
    { mode = "n"; key = ";h"; action = "<CMD>bdel<CR>"; }
    { mode = "n"; key = "<leader>hn"; action = "<CMD>bprev<CR>"; }
    { mode = "n"; key = "<leader>ha"; action = "<CMD>blast<CR>"; }
    { mode = "n"; key = "<leader>hi"; action = "<CMD>bfirst<CR>"; }
    { mode = "n"; key = "<leader>ho"; action = "<CMD>bnext<CR>"; }
    { mode = "n"; key = "<BS>"; action = "<C-^>"; } # previous buffer
    { mode = "n"; key = "<Left>"; action = "<C-o>"; } # jump positions within buffer
    { mode = "n"; key = "<Right>"; action = "<C-i>"; }
]
