{ config, lib, ... }: {
    spotify = {
        app_id = "chrome-open.spotify.com__-Default";
        cmd = ''chromium --js-flags=--no-decommit-pooled-pages --app="https://open.spotify.com"'';
        lazy = true;
    };
} // # terminal dropdowns
([
    { name = "term"; cmd = ""; }
    { name = "nixbuild"; cmd = "nixbuild loop"; }
    { name = "qalc"; }
    { name = "net"; }
    { name = "blue"; }
    # { name = "spotify"; cmd = "spotify_player"; lazy = true; }
] 
    |> map (let
        mk = attrs: let
            name = attrs.name;
            cmd = attrs.cmd or name;
            lazy = attrs.lazy or false;
        in {
            ${attrs.name} = let term = config.home.sessionVariables.TERMINAL; in {
                app_id = "dropdown-${name}";
                cmd = "${term} --class dropdown-${name} ${cmd}";
                inherit lazy;
            };
        };
    in mk) |> lib.mergeAttrsList
)
