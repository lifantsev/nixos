{
    col = import ./colors/catppuccin.nix;

    style = {
        rounding = false;
        animation = false;
    };

    window = let gaps = 5; in {
        border = 2;
        radius = 7;
        gaps-in = gaps;
        gaps-out = 2*gaps;
    };

    font = {
        code = (import ./fonts/import.nix) 11.5 ./fonts/victor-mono.nix;
        read = (import ./fonts/import.nix) 12 ./fonts/times-newer-roman.nix;

        tty = import ./fonts/tty-cozette.nix;
    };
}
