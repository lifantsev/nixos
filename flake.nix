# TODO write readme
# installed with the help of this guide
# https://github.com/nix-community/nixos-apple-silicon/blob/main/docs/uefi-standalone.md
{
    description = "configuration flake for asahi macbook";

    inputs = {
        # switched from 25.11 to 26.05
        nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";

        home-manager.url = "github:nix-community/home-manager/release-26.05";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";

        # FIXME kernel build error
        # (https://github.com/nix-community/nixos-apple-silicon/issues/427)
        # will pin to 26.05 when released
        nixos-apple-silicon.url = "github:nix-community/nixos-apple-silicon/release-2026-07-30";
        nixos-apple-silicon.inputs.nixpkgs.follows = "nixpkgs";

        # auxiliary
        niri = {
            # switched epireyn's (sodiboo's module is out of date)
            url = "github:epireyn/niri-flake";
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

        supervisor = {
            url = "github:lifantsev/supervisor";
            inputs.nixpkgs.follows = "nixpkgs";
            inputs.lg.follows = "lg";
        };

        manager = {
            url = "github:lifantsev/manager";
            inputs.supervisor.follows = "supervisor";
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
