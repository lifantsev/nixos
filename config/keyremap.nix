{ pkgs, username, ... }: {
    # every virtual keyboard needs a libinput quirk that marks it as an internal keyboard
    # that way, settings that rely on that (like disable touchpad while typing) work
    environment.etc."libinput/local-overrides.quirks".text = pkgs.lib.mkForce ''
        [Serial Keyboards]
        MatchUdevType=keyboard
        MatchName=Makima Virtual Keyboard/Mouse
        AttrKeyboardIntegration=internal
    '';

    # for gmmk pro keyboard, swap meta & alt (to match mac keyboard)
    services.keyd = {
        enable = false;
        keyboards.gmmk = {
            ids = [ "320f:5044" ];

            settings.main = {
                leftalt = "leftmeta";
                leftmeta = "leftalt";
            };
        };
    };

    # install makima service, configured in home-manager
    systemd.services.makima = {
        enable = true;

        description = "Makima remapping daemon";

        wantedBy = [ "default.target" ];

        environment = {
            MAKIMA_CONFIG = "/home/${username}/.config/makima";
            RUST_BACKTRACE="full";
            XDG_SESSION_TYPE="wayland";
            XDG_CURRENT_DESKTOP = "niri";
        };

        path = [
            pkgs.bash
            pkgs.niri
        ];

        serviceConfig = {
            Type = "simple";
            Restart = "always";
            RestartSec = 3;

            ExecStart = "${pkgs.writeShellScriptBin "makima-wrapped" ''
                # jank as fuck but it works
                export NIRI_SOCKET="$(find /run/user/*/niri* | head -n 1)"
                ${pkgs.makima}/bin/makima
            ''}/bin/makima-wrapped";

            User = username;
            Group = "input";
        };
    };
}

