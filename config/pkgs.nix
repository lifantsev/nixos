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
        lf
        spotify-player
        libqalculate

        ## OTHER
        zathura
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
        git
        gnupg
        upower
        sshfs
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
        pdftk
        yt-dlp
        tldr
        mediainfo
        playerctl
        mpvc
        mpc
    ];
}
