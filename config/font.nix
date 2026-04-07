{ rice, pkgs, ... }: {
    fonts = {
        packages = with pkgs; [
            pkgs.${rice.font.code.package}
            pkgs.${rice.font.read.package}

            # nerd-fonts.fira-code
        ];

        fontconfig.defaultFonts = {
            monospace = [ rice.font.code.name ];

            serif     = [ rice.font.read.name ];
            sansSerif = [ rice.font.read.name ];
        };
    };
}
