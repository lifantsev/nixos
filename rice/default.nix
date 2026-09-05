{
    col = import ./colors/catppuccin.nix;

    style = {
        rounding = false; # just use window.radius instead
        animation = false;
    };

    window = let gaps = 7; in {
        border = 2;
        radius = 7;
        gaps-in = gaps;
        gaps-out = builtins.floor (1.5*gaps);
    };

    font = {
        code = (import ./fonts/import.nix) 11.5 ./fonts/victor-mono.nix;
        read = (import ./fonts/import.nix) 12 ./fonts/times-newer-roman.nix;

        tty = import ./fonts/tty-cozette.nix;
    };
}
