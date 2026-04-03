{ inputs, rice, username, ... }:
let
    inherit username;
    homeDirectory = "/home/${username}";
in {
    programs.home-manager.enable = true;
    home = { inherit username homeDirectory; stateVersion = "25.11"; }; # DONT CHANGE STATE VERSION UNLESS YOU KNOW WHAT YOU ARE DOING! (set to the homemanager version at the time the config was created, it is used to prevent problems that might come from backwards incompatible changes in hm)

    _module.args = { inherit inputs rice username; }; # extra stuff to pass to imports

    imports = let
        imports = inputs.nixpkgs.lib.attrsets.filterAttrs (n: v: (v == "directory") || (v == "regular" && n != "default.nix")) (builtins.readDir ./.);
    in map (name: ./. + "/${name}") (builtins.attrNames imports) ++ [
        inputs.nixvim.homeModules.nixvim
    ];
}
