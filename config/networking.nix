{ hostname, ... }: {
    networking.hostName = hostname; # Define your hostname.

    # Configure network connections interactively with nmcli or nmtui.
    # TODO see if we can get away with just using iwd and no networkmanager (use iwctl)
    # NOTE there might be problems with vpn as a result, see about it
    networking.networkmanager = {
        enable = true;
        wifi.backend = "iwd";
    };
    networking.wireless.iwd = {
        enable = true;
        settings.General.EnableNetworkConfiguration = true;
    };
}
