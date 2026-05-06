{ pkgs, ... }@args: {
    environment.systemPackages = with pkgs; let
        entriesIn = path: map (name: path + "/${name}") (builtins.attrNames (builtins.readDir path));

        custom-pkgs = map (import ../pkgs/import.nix args) (entriesIn ../pkgs/apps ++ entriesIn ../pkgs/scripts);
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

        # NIRI
        xwayland-satellite

        # HYPRLAND
        pyprland

        # OTHER
        mako libnotify
        networkmanagerapplet wireguard-tools
        grim slurp
        brightnessctl
        wl-clipboard wtype
        wf-recorder

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
        ffmpeg
        file
        psmisc
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
