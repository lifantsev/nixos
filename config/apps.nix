{ pkgs, ... }: { environment.systemPackages = with pkgs; [
    zathura

    gnupg
    ripgrep
    upower
    kitty
    qutebrowser
    git
    vim
    zsh
    bash

    apple-cursor

    eza
    pass

    cmatrix
];}
