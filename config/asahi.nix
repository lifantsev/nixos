# settings specifically for asahi/mac
{ ... }: {
    hardware.asahi.enable = true;


    # previously firmware was from /boot/asahi/{all_firmware.tar.gz,kernelcache*}
    # as of nixos-apple-silicon/release-2026-07-30, it's /boot/vendorfw/firmware.cpio
    # to get the firmware, boot macos and run `https://alx.sh` & select "rebuild vendor firmware cache" option
    hardware.asahi.peripheralFirmwareDirectory = ./ignore/firmware; # copy the files here

    # sound
    hardware.asahi.setupAsahiSound = true;
    boot.kernelParams = [ "apple_dcp.hdmi_audio=1" ]; # doesn't seem to work (experimental)

    # 80% charging threshold
    services.udev.extraRules = ''
    SUBSYSTEM=="power_supply", KERNEL=="macsmc-battery", ATTR{charge_control_end_threshold}="80"
    '';
}
