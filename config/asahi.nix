# settings specifically for asahi
{ ... }: {
    # sound
    hardware.asahi.setupAsahiSound = true;

    # 80% charging threshold
    services.udev.extraRules = ''
    SUBSYSTEM=="power_supply", KERNEL=="macsmc-battery", ATTR{charge_control_end_threshold}="80"
    '';
}
