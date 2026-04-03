{ hostname, ... }: {
    networking.hostName = hostname; # Define your hostname.

    # Configure network connections interactively with nmcli or nmtui.
    networking.networkmanager = {
        enable = true;
        wifi.backend = "iwd";
    };
}
