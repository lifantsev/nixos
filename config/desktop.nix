# "desktop environment"
{ rice, ... }: {
    security.rtkit.enable = true;
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
    };

    programs.hyprland.enable = true;

    services.upower.enable = true;
    hardware.bluetooth.enable = true;

    security.sudo.extraConfig = "Defaults pwfeedback"; # show asterisks on sudo prompt

    # LY login manager config
    services.displayManager.ly.enable = true;
    services.displayManager.ly.settings = let
        mkCol = name: "0x08${rice.col.${name}.hex}";
    in {
        animation = "colormix";
        animation_frame_delay = 15; # ms

        initial_info_text = " < < < < < < < < <" +
                            " > > > > > > > > > ";
        input_len = 30; # length of input boxes
        hide_borders = true;

        colormix_col1 = mkCol "t0";
        colormix_col2 = mkCol "t0";
        colormix_col3 = mkCol "t1";

        fg = mkCol "fg";
        bg = mkCol "bg";
        border_fg = mkCol "blue";
        error_fg = mkCol "red";
        error_bg = mkCol "bg";

        clear_password = true; # clear on failure

        hide_key_hints = true;
        hide_version_string = true;
        hide_keyboard_locks = true;

        session_log = null;
    };
}
