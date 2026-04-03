# i use semicolon for all bindings that exit stuff
{ ... }: [
    # basic exit
    { mode = ["i" "v" "x" "s"]; key = ";n"; action = "<ESC>"; }
    { mode = "n"; key = ";n"; action = "ZZ"; }
    { mode = "c"; key = ";n"; action = "<c-c>"; }

    # actually typing a semicolon
    { mode = "i"; key = ";e"; action = "<ESC>A;<ESC>"; }
    { mode = "i"; key = ";a"; action = ";<ESC>"; }

    # reenter edit mode after exit
    { mode = "i"; key = ";l"; action = "<ESC>o"; }
    { mode = "i"; key = ";L"; action = "<ESC>O"; }
    { mode = "i"; key = ";k"; action = "<ESC>A"; }
    { mode = "i"; key = ";h"; action = "<ESC>I"; }
    { mode = "i"; key = ";c"; action = "<ESC><CMD>lua require('Comment.api').insert.linewise.eol()<CR>"; }
]
