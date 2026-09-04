# settings specifically for asahi/mac
{ ... }: {

    # sound
    hardware.asahi.setupAsahiSound = true;
    boot.kernelParams = [ "apple_dcp.hdmi_audio=1" ]; # doesn't seem to work (experimental)

    # 80% charging threshold
    services.udev.extraRules = ''
    SUBSYSTEM=="power_supply", KERNEL=="macsmc-battery", ATTR{charge_control_end_threshold}="80"
    '';
}
