{ pkgs, ... }: {
    programs.gpg = {
        # TODO maybe change default location to someplace other than home
        enable = true;
    };

    # NOTE after changing anything, run `gpgconf --reload gpg-agent` to apply
    # idk why this isn't in an activation script :/
    services.gpg-agent = let
        timeout = 60*60*24*3; # 3 days
    in {
        enable = true;

        pinentry.package = pkgs.pinentry-tty; # by default this is null
        extraConfig = "allow-loopback-pinentry";

        # enableSshSupport = true; # more research into opt required
        # theres some enable<shell>Integration, see docs ig

        defaultCacheTtl = timeout; # seconds
        defaultCacheTtlSsh = timeout;
        maxCacheTtl = timeout;
        maxCacheTtlSsh = timeout;
    };
}
