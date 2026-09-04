{ pkgs, ... }@args: {
    environment.systemPackages = with pkgs; (import ../pkgs args) ++ [
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

        ### ART
        gimp
        krita

        ## OTHER
        sioyek
        kitty
        kicad
        transmission_4-qt
        parted
        qrcode
        ipatool
        libplist
        gparted

        mkosi-full
        gptfdisk
        arch-install-scripts
        pacman

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
        # cope
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
        usbutils
        yt-dlp

        # IOS
        ifuse
        libimobiledevice
    ];
}
