{ rice, inputs, pkgs, ... }: {
    home.activation.kitty = inputs.home-manager.lib.hm.dag.entryAfter ["onFilesChange"]
        "$DRY_RUN_CMD kill $VERBOSE_ARG -SIGUSR1 $(${pkgs.procps}/bin/pgrep kitty)";

    programs.kitty = {
        enable = true;

        keybindings = {
            "ctrl+shift+c" = "copy_to_clipboard";
            "ctrl+shift+v" = "paste_from_clipboard";

            "shift+up" = "scroll_line_up";
            "shift+down" = "scroll_line_down";

            "ctrl+shift+l" = "change_font_size all 0";
            "ctrl+shift+tab" = "change_font_size all +2.0";
            "ctrl+shift+u" = "change_font_size all -2.0";

            "ctrl+o" = "new_window_with_cwd";

            "ctrl+shift+alt+t" = let kitty_clone_cwd = pkgs.writeShellScriptBin "kitty_clone_cwd" ''
                cd "$(kitty @ ls | jq -r ".[].tabs.[].windows.[] | select(.id == $1).foreground_processes.[].cwd" | head -n 1)"
                kitty @ detach-window --self
                $SHELL
            ''; in "launch ${kitty_clone_cwd}/bin/kitty_clone_cwd @active-kitty-window-id";
        };

        settings = with rice; {
            clear_all_shortcuts = true;
            enable_audio_bell = false;
            window_alert_on_bell = false;
            confirm_os_window_close = 0;
            allow_remote_control = true;

            font_size = font.code.size;
            window_padding_width = "2";
            scrollback_lines = 10000;
            update_check_interval = 0;
            mouse_hide_wait = 0;

            touch_scroll_multiplier = "1.7";
            wheel_scroll_multiplier = "5.0";

            disable_ligatures = "cursor";
            strip_trailing_spaces = "smart";
            copy_on_select = "clipboard";

            cursor_shape = "beam";
            cursor_beam_thickness = "1.5";
            cursor_stop_blinking_after = 0;

            url_style = "curly";
            undercurl_style = "thick-sparse";
            underline_hyperlinks = "always";

            background_opacity = "0.8";
            
            # Fonts

            font_family      = font.code.full.family;
            bold_font        = font.code.full.bold;
            italic_font      = font.code.full.italic;
            bold_italic_font = font.code.full.bold-italic;

            # Colors

            cursor = col.t6.h;
            cursor_text_color = col.bg.h;

            selection_foreground = col.fg.h;
            selection_background = col.t3.h;

            url_color = col.blue.h;

            foreground = col.fg.h;
            background = col.bg.h;

            color0  = col.bg.h;
            color8  = col.t2.h;
            color1  = col.red.h;
            color9  = col.red.h;
            color2  = col.green.h;
            color10 = col.green.h;
            color3  = col.yellow.h;
            color11 = col.orange.h;
            color4  = col.blue.h;
            color12 = col.blue.h;
            color5  = col.purple.h;
            color13 = col.purple.h;
            color6  = col.aqua.h;
            color14 = col.aqua.h;
            color7  = col.t4.h;
            color15 = col.fg.h;

            color22  = col.t2.h; # git diff-so-fancy green background
            color52  = col.t2.h; # git diff-so-fancy red background
        };
    };
}
