# notes for battery life
# barebones hyprland, and nvim installed: 12 hr, basically no daemons
{
    description = "configuration flake for asahi macbook";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";

        home-manager.url = "github:nix-community/home-manager/release-25.11";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";

        nixvim.url = "github:nix-community/nixvim/nixos-25.11";
        xremap.url = "github:xremap/nix-flake";
    };

    outputs = { self, nixpkgs, home-manager, ... }@inputs: let
        specialArgs = {
            inherit inputs;
            rice = import ./rice;
            hostname = "nixbook";
            username = "mark";
        }; 
    in {
        nixosConfigurations.${specialArgs.hostname} = nixpkgs.lib.nixosSystem {
            inherit specialArgs;
            system = "aarch64-linux";
            modules = [ 
                ./config home-manager.nixosModules.home-manager
                { home-manager = {
                    useGlobalPkgs = true;
                    useUserPackages = true;
                    users.${specialArgs.username} = import ./home specialArgs;
                };}
            ];
        };
    };
}
