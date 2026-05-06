{ inputs, rice, username, ... }:
let
    inherit username;
    homeDirectory = "/home/${username}";
in {
    programs.home-manager.enable = true;
    home = { inherit username homeDirectory; stateVersion = "25.11"; }; # DONT CHANGE STATE VERSION UNLESS YOU KNOW WHAT YOU ARE DOING! (set to the homemanager version at the time the config was created, it is used to prevent problems that might come from backwards incompatible changes in hm)

    _module.args = { inherit inputs rice username; };

    imports = let
        imports = inputs.nixpkgs.lib.attrsets.filterAttrs (n: v: (v == "directory") || (v == "regular" && n != "default.nix")) (builtins.readDir ./.);
    in map (name: ./. + "/${name}") (builtins.attrNames imports) ++ [
        inputs.lifantsev-nixvim.homeManagerModules.default
        inputs.niri-bind-modes.homeManagerModules.default
        inputs.niridrop.homeManagerModules.default
        inputs.dropmenu.homeManagerModules.default
        inputs.pinentry-niridrop.homeManagerModules.default
    ];
}
