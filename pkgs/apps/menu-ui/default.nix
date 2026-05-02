{ pkgs, ... }: {
    execer = [
        "cannot:${pkgs.niridrop}/bin/niridrop"
        "cannot:${pkgs.fzf}/bin/fzf"
    ];

    inputs = [
        pkgs.fzf
        pkgs.niridrop
        pkgs.lg
        pkgs.gnugrep
        pkgs.gnused
        pkgs.gawk
    ];
}
