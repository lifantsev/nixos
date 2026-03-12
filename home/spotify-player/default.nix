{ lib, rice, ... }@args: {
    programs.spotify-player = {
        enable = true;

        settings = import ./options.nix;

        themes = [{
            name = "main";
            component_style = import ./theme.nix args;
        }];

        actions = lib.attrsets.mapAttrsToList (key: act: { action = act; key_sequence = key; }) (import ./binds.nix).actions;

        keymaps = lib.attrsets.mapAttrsToList (key: cmd: { command = cmd; key_sequence = key; }) ({
            # unbind default binds
            "n" = "None"; "p" = "None"; "space" = "None"; "." = "None"; "C-r" = "None"; "C-s" = "None";
            "+" = "None"; "-" = "None"; "_" = "None"; "^" = "None"; ">" = "None"; "<" = "None";
            "C-c" = "None"; "q" = "None"; "esc" = "None"; "j" = "None"; "C-n" = "None"; "down" = "None";
            "k" = "None"; "C-p" = "None"; "up" = "None"; "page_down" = "None"; "C-f" = "None"; "page_up" = "None";
            "C-b" = "None"; "g g" = "None"; "home" = "None"; "G" = "None"; "end" = "None"; "enter" = "None";
            "r" = "None"; "R" = "None"; "g a" = "None"; "C-space" = "None"; "a" = "None"; "A" = "None";
            "Z" = "None"; "C-z" = "None"; "tab" = "None"; "backtab" = "None"; "T" = "None"; "D" = "None";
            "/" = "None"; "u p" = "None"; "u a" = "None"; "u A" = "None"; "g space" = "None"; "g t" = "None";
            "g r" = "None"; "g y" = "None"; "g L" = "None"; "l" = "None"; "g l" = "None"; "g s" = "None";
            "g b" = "None"; "z" = "None"; "?" = "None"; "C-h" = "None"; "backspace" = "None"; "C-q" = "None";
            "O" = "None"; "s t" = "None"; "s a" = "None"; "s A" = "None"; "s D" = "None"; "s d" = "None";
            "s l a" = "None"; "s l r" = "None"; "s r" = "None"; "C-k" = "None"; "C-j" = "None"; "N" = "None";
            "g c" = "None"; "C-g" = "None";
        } // (import ./binds.nix).keymaps); # custom binds on RHS so they override defaults
    };
}
