{ pkgs, ... }@args: {
    environment.systemPackages = with pkgs; let
        stemOf = file: builtins.elemAt (builtins.match "^(.*)\\.[a-z]*$" (builtins.baseNameOf file)) 0;

        filesIn = path: map (name: path + "/${name}") (builtins.attrNames (lib.attrsets.filterAttrs (n: v: v == "regular") (builtins.readDir path)));

        files = filesIn ./custom-apps ++ filesIn ./custom-scripts;
        custom-pkgs = map (file: if lib.hasSuffix ".nix" file then import file args else pkgs.writeShellScriptBin (stemOf file) (builtins.readFile file)) files;
    in custom-pkgs ++
    [
        zathura
        kitty
        qutebrowser brave

        vim
        zsh
        bash

        apple-cursor

        git
        gnupg
        upower
        sshfs
        lf
        fzf
        eza
        jq
        unzip
        ripgrep
        bc
        socat
        ansifilter
        trash-cli
        dragon-drop
        bat
        file
        mpv
        imv
        libqalculate
        pdftk
        yt-dlp
        tldr

        pyprland
        mako libnotify
        brightnessctl
        networkmanagerapplet
        grim slurp

        spotify-player
        kicad

        wl-clipboard wtype

        asahi-nvram # to turn off bootsound: `sudo asahi-nvram write system:StartupMute=%01`
        asahi-bless # to boot into macos temporarily
    ];
}
