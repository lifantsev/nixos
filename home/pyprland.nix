{ config, pkgs, lib, ... }: {
    home.activation.pyprland = lib.hm.dag.entryAfter ["onFilesChange"] "$DRY_RUN_CMD ${pkgs.pyprland}/bin/pypr reload > /dev/null";

    # NOTE make sure to set float when class='scratchpad' in your wm config

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

        ${term_pad { name = "menu-ui";  sh = "menu-ui"; }}
        ${term_pad { name = "getpin-ui";sh = "getpin-ui"; size=sizes.mini; }}

        ${term_pad { name = "term";     sh = ""; }}
        ${term_pad { name = "qalc";     sh = "qalc"; }}
        ${term_pad { name = "blue";     sh = "blue"; }}
        ${term_pad { name = "net";      sh = "net"; }}
        ${term_pad { name = "nixbuild"; sh = "nixbuild loop"; }}
        ${term_pad { name = "spotify";  sh = "spotify_player"; lazy = true; }}
    '';
}
