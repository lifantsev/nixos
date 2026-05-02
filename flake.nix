# TODO write readme
{
    description = "configuration flake for asahi macbook";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";

        home-manager.url = "github:nix-community/home-manager/release-25.11";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";

        lifantsev-nixvim.url = "github:lifantsev/nixvim";
        niri-bind-modes.url = "github:lifantsev/niri-bind-modes";
        lg.url = "github:lifantsev/lg";
    };

    outputs = { self, nixpkgs, home-manager, ... }@inputs: let
        system = "aarch64-linux";

        specialArgs = {
            inherit inputs system;
            rice = import ./rice;
            hostname = "nixbook";
            username = "mark";
        }; 

        overlays = [( final: prev: {
            lg = inputs.lg.packages.${system}.default;
        })];
    in {
        nixosConfigurations.${specialArgs.hostname} = nixpkgs.lib.nixosSystem {
            inherit specialArgs system;
            modules = [ 
                ./config
                { nixpkgs.overlays = overlays; }
                home-manager.nixosModules.home-manager { home-manager = {
                    useGlobalPkgs = true;
                    useUserPackages = true;
                    users.${specialArgs.username} = import ./home specialArgs;
                };}
            ];
        };
    };
}
