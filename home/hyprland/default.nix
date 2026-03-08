{ config, rice, ... }: {
    wayland.windowManager.hyprland.enable = true;
    wayland.windowManager.hyprland.settings = {
        exec-once = [
            "kitty" # TODO replace this with variable
        ];

        exec = [
            "hyprctl setcursor ${config.home.pointerCursor.name} ${toString config.home.pointerCursor.size}"
        ];

        env = [ "XCURSOR_SIZE,${toString config.home.pointerCursor.size}" ];

        # TODO setup monitor = line
        monitor = [
            "eDP-1,3456x2160@60,0x0,2"
            ",preferred,auto,auto"
        ];

        dwindle = {
            preserve_split = true;
            smart_resizing = false;
            permanent_direction_override = true;
            default_split_ratio = 1.1;
        };

        general = {
            border_size = rice.window.border;
            gaps_in = rice.window.gaps-in;
            gaps_out = rice.window.gaps-out;

            "col.inactive_border" = "rgba(00000000)";
            "col.nogroup_border"  = "rgba(00000000)";
            "col.active_border"         = "0xFF${rice.col.mg.hex}";
            "col.nogroup_border_active" = "0xFF${rice.col.mg.hex}";

            # TODO checkout scrolling and monocle layouts

            no_focus_fallback = true; # don't wraparound when switching windows
        };

        decoration.blur.enabled = false; # if enabled, make sure only 1 pass for efficiency
        decoration.shadow.enabled = false;
        animations.enabled = false;

        input = {
            repeat_rate = 60;
            repeat_delay = 160;

            sensitivity = 0.3;

            follow_mouse = 1;
            focus_on_close = 1;

            # touchpad scrollfactor can be adjusted btw
        };

        gesture = [ "3, horizontal, workspace" ];
        gestures = {
            workspace_swipe_use_r = true;
            workspace_swipe_distance = 999999;
            workspace_swipe_min_speed_to_force = 0;
            workspace_swipe_cancel_ratio = 0;
            workspace_swipe_direction_lock = true;
        };

        binds = {
            workspace_center_on = 1;
            allow_workspace_cycles = true;
        };

        misc = {
            disable_hyprland_logo = true;
            disable_splash_rendering = true;
            force_default_wallpaper = 0;

            font_family = rice.font.name;

            enable_swallow = true;
            swallow_regex = "^(kitty)$"; # TODO update this to use a variable

            middle_click_paste = false;

            # NOTE potentially saves battery to use disable_autoreload
        };

        cursor.inactive_timeout = 15;

        # xwayland.force_zero_scaling = true; # NOTE this might improve image quality

        # below might be needed for setting up scratchpad
        # windowrulev2 = float,class:^(scratchpad)$
        # windowrulev2 = workspace special silent,class:^(scratchpad)$
    };


    wayland.windowManager.hyprland.extraConfig = ''
$mainMod = SUPER # Sets "Windows" key as main modifier

# Example binds, see https://wiki.hypr.land/Configuring/Binds/ for more
bind = $mainMod, T, exec, kitty
bind = $mainMod, D, killactive,

# Move focus with mainMod + arrow keys
bind = $mainMod, N, movefocus, l
bind = $mainMod, O, movefocus, r
bind = $mainMod, A, movefocus, u
bind = $mainMod, I, movefocus, d

# Scroll through existing workspaces with mainMod + scroll
bind = $mainMod, Y, workspace, r+1
bind = $mainMod, C, workspace, r-1

bind = $mainMod SHIFT, Y, movetoworkspace, r+1
bind = $mainMod SHIFT, C, movetoworkspace, r-1

# Move/resize windows with mainMod + LMB/RMB and dragging
bindm = $mainMod, mouse:272, resizewindow

# Laptop multimedia keys for volume and LCD brightness
bindel = ,XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+
bindel = ,XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
bindel = ,XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
bindel = ,XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+
bindel = ,XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-
    '';
}
