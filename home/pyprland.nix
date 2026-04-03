{ config, pkgs, lib, ... }: {
    home.activation.pyprland = lib.hm.dag.entryAfter ["onFilesChange"] "$DRY_RUN_CMD ${pkgs.pyprland}/bin/pypr reload > /dev/null";

    # NOTE make sure to automatically float windows with scratchpad in title

    xdg.configFile."hypr/pyprland.toml".text = let
        sizes = let
            size = width: height: /* toml */ ''
                size = "${toString width}% ${toString height}%"
                position = "${toString ((100 - width) / 2)}% ${toString ((100 - height) / 2)}%"
            '';
        in {
            default = size 70 70;
            mini = size 30 16;
        };

        pad = { name, command, lazy, size?sizes.default }: /*toml*/ ''
            [scratchpads.${name}]
            command = "${command}"
            lazy = ${if lazy then "true" else "false"}
            ${size}
        '';

        term_pad = { name, sh, lazy?false, size?sizes.default }: pad {
            inherit name lazy size;
            command = "${config.home.sessionVariables.TERMINAL} --class scratchpad ${sh}";
        };
    in /*toml*/ ''
        [pyprland]
        plugins = [ "scratchpads" ]

        ${term_pad { name = "term";     sh = ""; }}
        ${term_pad { name = "menu";     sh = "menuui"; }}
        ${term_pad { name = "qalc";     sh = "qalc"; }}
        ${term_pad { name = "nixbuild"; sh = "nixbuild loop"; }}
        ${term_pad { name = "spotify";  sh = "spotify_player"; lazy = true; }}

        ${term_pad { name = "gpg";  sh = "$XDG_CONFIG_HOME/hypr/pyprland/gpg.sh"; lazy = true; size = sizes.mini; }}
    '';

    xdg.configFile."hypr/pyprland/gpg.sh" = {
        executable = true;
        text = /*sh*/ ''
            #!/usr/bin/env bash
            echo "Please unlock password store gpg key"
            gpg --pinentry-mode loopback --quiet -d $PASSWORD_STORE_DIR/blank.gpg
        '';
    };
}
