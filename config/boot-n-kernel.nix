{ ... }: {
    # Use the systemd-boot EFI boot loader.
    boot.loader.systemd-boot.enable = true;

    boot.supportedFilesystems = [ "exfat" ];
    
    boot.kernelModules = [ "uinput" ];

    services.udev.extraRules = ''
        KERNEL=="uinput", GROUP="input", MODE="0660"
    '';
}
