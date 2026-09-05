{ rice, pkgs, ... }: {
    console = {
        earlySetup = true;

        font = rice.font.tty.name; # a bit smaller but nice font

        packages = [ pkgs.${rice.font.tty.package} ];

        colors = with rice.col; [
            bg.hex
            brown.hex
            green.hex
            orange.hex
            blue.hex
            purple.hex
            aqua.hex
            t5.hex
            t1.hex
            red.hex
            green.hex
            yellow.hex
            blue.hex
            purple.hex
            aqua.hex
            fg.hex
        ];
    };

    services.udev.extraRules = ''
        ACTION=="add", SUBSYSTEM=="graphics", KERNEL=="fb*", RUN+="${pkgs.kbd}/bin/setfont ${rice.font.tty.name}"
    '';
}
