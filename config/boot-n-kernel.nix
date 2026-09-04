{ ... }: {
    # Use the systemd-boot EFI boot loader.
    boot.loader.systemd-boot.enable = true;

    boot.supportedFilesystems = [ "exfat" ];
}
