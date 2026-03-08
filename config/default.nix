{ pkgs, lib, username, ... }: {
    imports = let
        fileset = lib.attrsets.filterAttrs (n: v: v == "regular" && n != "default.nix") (builtins.readDir ./.);
    in map (file: ./. + "/${file}") (builtins.attrNames fileset) ++ [
        ./ignore/hardware-configuration.nix # nixos hardware scan
        ./apple-silicon-support # support module from nixos-apple-silicon
    ];

    hardware.asahi.peripheralFirmwareDirectory = ./ignore/firmware; # files copied from /mnt/boot/asahi/{all_firmware.tar.gz,kernelcache*} during install

    nixpkgs.config.allowUnfree = true;
    nix.settings.experimental-features = [ "flakes" "nix-command" ];
    time.timeZone = "America/Los_Angeles";

    # programs.zsh.enable = true;
    users.users.${username} = {
        isNormalUser = true;
        description = "Mark Lifantsev";
        extraGroups = [ "wheel" "networkmanager" ];
        shell = pkgs.zsh;
        ignoreShellProgramCheck = true;
        home = "/home/${username}";
    };

    # DONT CHANGE UNLESS YOU KNOW WHAT YOU ARE DOING
    system.stateVersion = "25.11"; # Did you read the comment?
}

