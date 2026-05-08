# TODO make this a list that gets zipped for readability
{ config, ... }: let 
    term = config.home.sessionVariables.TERMINAL;
    mkTerm = name: sh: extra: {
        ${name} = {
            app_id = "dropdown-${name}";
            cmd = "${term} --class dropdown-${name} ${sh}";
        } // extra;
    };
in {} //
mkTerm "term" "" {} //
mkTerm "qalc" "qalc" {} //
mkTerm "net" "net" {} //
mkTerm "blue" "blue" {} //
mkTerm "nixbuild" "nixbuild loop" {} //
mkTerm "spotify" "spotify_player" { lazy = true; } //
{}
