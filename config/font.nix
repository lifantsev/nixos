{ rice, pkgs, ... }: {
    fonts = {
        packages = with pkgs; [
            victor-mono
            nerd-fonts.fira-code
            times-newer-roman

            monocraft
            scientifica
            comic-mono
        ];

        fontconfig.defaultFonts = {
            monospace = [ rice.fonts.code.name ];

            serif     = [ rice.fonts.read.name ];
            sansSerif = [ rice.fonts.read.name ];
        };
    };
}
