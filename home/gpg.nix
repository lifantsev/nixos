{ pkgs, ... }@args: {
    programs.gpg.enable = true;

    # NOTE after changing anything, run `gpgconf --reload gpg-agent` to apply
    # idk why this isn't in an activation script :/
    services.gpg-agent = let
        timeout = 60*60*24*3; # 3 days
    in {
        enable = true;

        pinentry.package = pkgs.pinentry-niridrop;

        extraConfig = ''
            allow-loopback-pinentry
        '';
        # log-file /tmp/gpg-agent.log
        # debug-level advanced
        # debug-pinentry

        enableSshSupport = true; # use ssh-copy-id <remote-machine> to use key to login
        sshKeys = [ "FB55A337A9642B6A1AE533D93591A61DD30D60D0" ]; # keygrip, not sensitive info
        # to get the keygrip:
        # make authentication subkey: gpg --expert --edit-key, addkey (8), just Authenticate, save
        # then gpg --list-keys --with-keygrip (& pick the auth key)

        enableZshIntegration = true;

        defaultCacheTtl = timeout; # seconds
        defaultCacheTtlSsh = timeout;
        maxCacheTtl = timeout;
        maxCacheTtlSsh = timeout;
    };
}
