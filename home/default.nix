{ inputs, rice, username, ... }:
let
    inherit username;
    homeDirectory = "/home/${username}";
in {
    programs.home-manager.enable = true;
    home = { inherit username homeDirectory; stateVersion = "25.11"; }; # DONT CHANGE STATE VERSION UNLESS YOU KNOW WHAT YOU ARE DOING! (set to the homemanager version at the time the config was created, it is used to prevent problems that might come from backwards incompatible changes in hm)

    _module.args = { inherit rice; inherit inputs; }; # extra stuff to pass to imports
    imports = let
        directories = inputs.nixpkgs.lib.attrsets.filterAttrs (n: v: v == "directory") (builtins.readDir ./.);
    in [
        inputs.nixvim.homeModules.nixvim
    ] ++ map (name: ./. + "/${name}") (builtins.attrNames directories);
}
