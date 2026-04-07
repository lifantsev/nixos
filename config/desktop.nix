# "desktop environment"
{ ... }: {
    security.rtkit.enable = true;
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
    };

    # this should fix audio crackling
    # https://bbs.archlinux.org/viewtopic.php?id=283324
    # https://gist.github.com/Pitometsu/6db6ec921e19a7b37472
    boot.postBootCommands = "echo 2048 > /sys/class/rtc/rtc0/max_user_freq";

    programs.hyprland.enable = true;

    services.upower.enable = true;
    hardware.bluetooth.enable = true;
    environment.etc."wireguard".source = ../ignore/wireguard; # put wg.conf files for vpn here

    security.sudo.extraConfig = "Defaults pwfeedback"; # show asterisks on sudo prompt

    # handling power keys & stuff if we ever want to
    # services.logind.settings.Login
}
