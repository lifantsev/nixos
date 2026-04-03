{ lib, ... }: let modes = [ "n" "v" "s" "x" "o" ]; in [
    { mode = modes; key = "h"; action = "i"; }
    { mode = modes; key = "h"; action = "i"; }
    { mode = modes; key = "k"; action = "a"; }
    { mode = modes; key = "j"; action = "n"; }
    { mode = modes; key = "l"; action = "o"; }

    { mode = modes; key = "H"; action = "I"; }
    { mode = modes; key = "K"; action = "A"; }
    { mode = modes; key = "J"; action = "N"; }
    { mode = modes; key = "L"; action = "O"; }

    { mode = modes; key = "r"; action = "d"; }
    { mode = modes; key = "R"; action = "D"; }
    { mode = modes; key = "d"; action = "r"; }
    { mode = modes; key = "D"; action = "R"; }

    { mode = modes; key = "n"; action = "h"; }
    { mode = lib.lists.remove "n" modes; key = "a"; action = "k"; }
    { mode = "n"; key = "a"; action = "gk"; }
    { mode = lib.lists.remove "n" modes; key = "i"; action = "j"; }
    { mode = "n"; key = "i"; action = "gj"; }
    { mode = modes; key = "o"; action = "l"; }

    { mode = "n"; key = "N"; action = "mzJ`z"; }
    { mode = lib.lists.remove "n" modes; key = "N"; action = "H"; }

    { mode = "v"; key = "A"; action = ":m '<-2<cr>gv=gv"; } # moves line up in visual mode
    { mode = "n"; key = "A"; action = "<C-u>"; } # goes up and down a page, keeping cursor centered
    { mode = "n"; key = "<up>"; action = "<C-u>"; }
    { mode = "o"; key = "A"; action = "K"; }

    { mode = "v"; key = "I"; action = ":m '>+1<cr>gv=gv"; }
    { mode = "n"; key = "I"; action = "<c-d>"; }
    { mode = "n"; key = "<down>"; action = "<C-d>"; }
    { mode = "o"; key = "I"; action = "J"; }

    { mode = modes; key = "O"; action = "L"; }
]
