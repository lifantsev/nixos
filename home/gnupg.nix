{ pkgs, ... }: {
    programs.gpg.enable = true;

    # NOTE after changing anything, run `gpgconf --reload gpg-agent` to apply
    # idk why this isn't in an activation script :/
    services.gpg-agent = let
        timeout = 60*60*24*3; # 3 days
    in {
        enable = true;

        pinentry.package = pkgs.pinentry-qt;
        # i suspect sometimes the tty pinentry prints to the wrong terminal (specifically with git ssh verification)
        # pinentry.package = pkgs.pinentry-tty;
        extraConfig = "allow-loopback-pinentry";

        enableSshSupport = true;
        sshKeys = [ "FB55A337A9642B6A1AE533D93591A61DD30D60D0" ];

        enableZshIntegration = true;

        defaultCacheTtl = timeout; # seconds
        defaultCacheTtlSsh = timeout;
        maxCacheTtl = timeout;
        maxCacheTtlSsh = timeout;
    };
}
