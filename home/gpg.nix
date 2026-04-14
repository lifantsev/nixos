{ pkgs, ... }@args: {
    programs.gpg.enable = true;

    # NOTE after changing anything, run `gpgconf --reload gpg-agent` to apply
    # idk why this isn't in an activation script :/
    services.gpg-agent = let
        timeout = 60*60*24*3; # 3 days
    in {
        enable = true;

        pinentry.package = pkgs.pinentry-qt;
        # pinentry.package = (import ../pkgs/import.nix args) ../pkgs/apps/pinentry-pypr;
        # pinentry.package = (import ../pkgs/import.nix args) ../pkgs/apps/pinentry-bash;

        # TODO remove logging
        extraConfig = ''
            allow-loopback-pinentry
            log-file /tmp/gpg-agent.log
            debug-level advanced
            debug-pinentry
        '';

        enableSshSupport = true;
        sshKeys = [ "FB55A337A9642B6A1AE533D93591A61DD30D60D0" ]; # keygrip, not sensitive info

        enableZshIntegration = true;

        defaultCacheTtl = timeout; # seconds
        defaultCacheTtlSsh = timeout;
        maxCacheTtl = timeout;
        maxCacheTtlSsh = timeout;
    };

    qt.platformTheme = "gtk2"; # gtk theme in cursor-and-gtk.nix
}
