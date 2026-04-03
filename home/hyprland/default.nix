{ config, lib, rice, ... }@args: {
    wayland.windowManager.hyprland.enable = true;

    xdg.configFile."hypr/sh" = {
        source = ./sh;
        recursive = true;
    };

    # submap keybinds
    wayland.windowManager.hyprland.extraConfig = let
        mkBindsStr = binds: lib.strings.concatStrings (map (b: "bind = ${b}\n") binds);
        mkSubmapStr = submap: binds: "submap = ${submap}\n${mkBindsStr binds}submap = reset\n";
    in lib.strings.concatStrings (lib.attrsets.mapAttrsToList mkSubmapStr (import ./binds.nix args).submaps);

    wayland.windowManager.hyprland.settings = {
        binde = (import ./binds.nix args).bind;
        bindm = [ "SUPER, mouse:272, resizewindow" ];

        exec-once = [
            "pypr"
            "drop init"
            "$XDG_CONFIG_HOME/hypr/sh/warp-cursor-on-window-open.sh"
        ];

        exec = [
            "$XDG_CONFIG_HOME/hypr/sh/notcron.sh"
            "hyprctl setcursor ${config.home.pointerCursor.name} ${toString config.home.pointerCursor.size}"
        ];

        env = [ "XCURSOR_SIZE,${toString config.home.pointerCursor.size}" ];

        # TODO setup monitor = line
        monitor = [
            "eDP-1,3456x2160@60,0x0,2"
            ",preferred,auto,auto"
        ];

        windowrulev2 = [
            "float,class:^(scratchpad)$" # rules to make pypr scratchpads work
            "workspace special silent,class:^(scratchpad)$"

            "bordersize 0, floating:0, onworkspace:w[t1]" # remove border when only 1 window open
        ];

        dwindle = {
            preserve_split = true;
            smart_resizing = false;
            permanent_direction_override = true;
            default_split_ratio = 1.1;
        };

        general = {
            border_size = rice.window.border;
            gaps_in = 0;
            gaps_out = 0;
            # gaps_in = rice.window.gaps-in;
            # gaps_out = rice.window.gaps-out;

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

            font_family = rice.fonts.code.name;

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
}
