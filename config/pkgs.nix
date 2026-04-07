{ pkgs, ... }@args: {
    environment.systemPackages = with pkgs; let
        stemOf = file: builtins.elemAt (builtins.match "^(.*)\\.[a-z]*$" (builtins.baseNameOf file)) 0;

        filesIn = path: map (name: path + "/${name}") (builtins.attrNames (lib.attrsets.filterAttrs (n: v: v == "regular") (builtins.readDir path)));

        files = filesIn ./custom-apps ++ filesIn ./custom-scripts;
        custom-pkgs = map (file: if lib.hasSuffix ".nix" file then import file args else pkgs.writeShellScriptBin (stemOf file) (builtins.readFile file)) files;
    in custom-pkgs ++
    [
        #############
        # USER APPS #
        #############

        ### BROWSERS
        qutebrowser
        brave

        ### TUI
        zsh
        bash
        vim
        git
        lf
        spotify-player
        libqalculate

        ## OTHER
        sioyek
        kitty
        kicad

        ###############
        # DESKTOP ENV #
        ###############

        # HYPRLAND
        pyprland

        # OTHER
        mako libnotify
        networkmanagerapplet wireguard-tools
        grim slurp
        brightnessctl
        wl-clipboard wtype

        #########
        # OTHER #
        #########

        asahi-nvram # to turn off bootsound: `sudo asahi-nvram write system:StartupMute=%01`
        asahi-bless # to boot into macos temporarily: `sudo asahi-bless --next --set-boot-macos`

        #############
        # CLI UTILS #
        #############
        ansifilter
        bat
        bc
        dragon-drop
        eza
        file
        fzf
        gnupg
        imv
        jq
        mediainfo
        mpc
        mpv
        mpvc
        pdftk
        playerctl
        ripgrep
        socat
        sshfs
        tldr
        trash-cli
        unzip
        upower
        yt-dlp
    ];
}
