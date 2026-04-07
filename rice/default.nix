{
    col = import ./colors/catppuccin.nix;

    font = {
        code = import ./fonts/victor-mono.nix;
        read = import ./fonts/times-newer-roman.nix;
        tty = import ./fonts/tty-cozette.nix;
    };

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
}
