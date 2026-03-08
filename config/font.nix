{ rice, pkgs, ... }: let mainfont = rice.font.name; in {
    fonts = {
        packages = with pkgs; [
            victor-mono
            nerd-fonts.fira-code

            monocraft
            scientifica
            comic-mono
        ];

        fontconfig.defaultFonts = {
            serif     = [ mainfont "FiraCode" ];
            sansSerif = [ mainfont "FiraCode" ];
            monospace = [ mainfont "FiraCode" ];
        };
    };
}
