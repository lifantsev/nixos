{ ... }: {
    # Use the systemd-boot EFI boot loader.
    boot.loader.systemd-boot.enable = true;

    boot.kernelParams = [ "apple_dcp.hdmi_audio=1" ]; # doesn't seem to work (experimental)

    boot.supportedFilesystems = [ "exfat" ];
}
