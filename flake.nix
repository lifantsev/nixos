# TODO write readme
# installed with the help of this guide
# https://github.com/nix-community/nixos-apple-silicon/blob/main/docs/uefi-standalone.md
{
    description = "configuration flake for asahi macbook";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";

        home-manager.url = "github:nix-community/home-manager/release-25.11";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";

        # FIXME using master branch to get around kernel build error
        # (https://github.com/nix-community/nixos-apple-silicon/issues/427)
        # will revert to a stable branch when this is fixed
        nixos-apple-silicon.url = "github:nix-community/nixos-apple-silicon";
        nixos-apple-silicon.inputs.nixpkgs.follows = "nixpkgs";

        # auxiliary
        niri = {
            url = "github:sodiboo/niri-flake";
            inputs.nixpkgs-stable.follows = "nixpkgs";
        };

        # my flakes
        niri-bind-modes.url = "github:lifantsev/niri-bind-modes";

        niridrop = {
            url = "github:lifantsev/niridrop";
            inputs.nixpkgs.follows = "nixpkgs";
            inputs.lg.follows = "lg";
        };

        lifantsev-nixvim = {
            url = "github:lifantsev/nixvim";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        lg = {
            url = "github:lifantsev/lg";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        dropmenu = {
            url = "github:lifantsev/dropmenu";
            inputs.nixpkgs.follows = "nixpkgs";
            inputs.lg.follows = "lg";
        };

        pinentry-dropdown = {
            url = "github:lifantsev/pinentry-dropdown";
            inputs.nixpkgs.follows = "nixpkgs";
            inputs.lg.follows = "lg";
        };
    };

    outputs = { nixpkgs, home-manager, ... }@inputs: let
        system = "aarch64-linux";

        specialArgs = {
            inherit inputs system;
            rice = import ./rice;
            hostname = "nixbook";
            username = "mark";
        }; 
    in {
        nixosConfigurations.${specialArgs.hostname} = nixpkgs.lib.nixosSystem {
            inherit specialArgs system;
            modules = [ 
                ./config
                home-manager.nixosModules.home-manager { home-manager = {
                    useGlobalPkgs = true;
                    useUserPackages = true;
                    users.${specialArgs.username} = import ./home specialArgs;
                };}
            ];
        };
    };
}
