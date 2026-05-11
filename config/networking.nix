{ hostname, ... }: {
    networking.hostName = hostname;

    # Configure network connections interactively with nmcli or nmtui.
    networking.networkmanager = {
        enable = true;
        wifi.backend = "iwd";
    };
}
