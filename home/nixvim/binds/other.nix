{ ... }: [
    # undo redo
    { mode = "n"; key = "U"; action = "<CMD>silent redo<cr>"; }
    { mode = "n"; key = "u"; action = "<CMD>silent undo<cr>"; }

    # quick sed binds
    { mode = "v"; key = "<leader>s"; action = "\"hy:%s/<c-r>h//g<left><left> <BS>"; }
    { mode = "n"; key = "<c-s>"; action = ":%s/"; }
    { mode = "v"; key = "<c-s>"; action = ":s/"; }
    
    # indent
    { mode = "n"; key = "<c-t>"; action = ">>"; }
    { mode = "n"; key = "<c-d>"; action = "<<"; }
    { mode = "v"; key = "<c-t>"; action = ">gv"; }
    { mode = "v"; key = "<c-d>"; action = "<gv"; }

    # incr/decr number
    { mode = "n"; key = "+"; action = "<c-a>"; }
    { mode = "n"; key = "-"; action = "<c-x>"; }

    # insert semicolon to the right
    { mode = "i"; key = "<c-;>"; action = ";<left>"; }
]
