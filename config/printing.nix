{ pkgs, ... } : {
    # to add a printer go to http://localhost:631/admin
    # driver to use: HL-1250 (with brother HL-2170w printer)

    # enable this stuff when needed
    services.printing = {
        enable = true;
        drivers = [ pkgs.gutenprint ];
    };

    services.avahi = {
        enable = true;
        nssmdns4 = true;
        openFirewall = true;
    };
}
