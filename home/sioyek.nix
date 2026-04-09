{ rice, ... }: {
    programs.sioyek = {
        enable = true;

        bindings = {
            goto_beginning = "g";
            goto_end = "G";

            goto_left_smart = "^";
            goto_right_smart = "$";

            move_right = "n";
            move_up = "a";
            move_down = "i";
            move_left = "o";

            next_page = "I";
            previous_page = "A";

            close_window = ";";
            goto_toc = "t";

            search = "/";
            next_item = "j";
            previous_item = "J";
            open_link = "f";

            zoom_in = "<tab>";
            zoom_out = "u";
            fit_to_page_width_smart= "l";
            fit_to_page_height_smart = "L";

            rotate_clockwise = "r";
            rotate_counterclockwise = "R";

            set_mark = "m";
            goto_mark = "'";

            copy = "y";

            command = ":";

            toggle_custom_color = "V";
            toggle_highlight = "<C-v>";

            keyboard_select = "v";
        };

        config = {
            vertical_move_amount = "0.5";

            startup_commands = "toggle_custom_color";
            should_launch_new_window = "1";
            should_launch_new_instance = "1";
            should_draw_unrendered_pages = "1";

            ui_font = rice.font.code.full.family;
            font_size = toString rice.font.code.size;

            collapsed_toc = "1";
            flat_toc = "0";
            case_sensitive_search = "1";

            page_separator_width = "3";
            page_separator_color = rice.col.t1.h;

            custom_color_mode_empty_background_color = rice.col.bg.h;
            background_color = rice.col.bg.h;

            custom_background_color = rice.col.bg.h;
            custom_text_color = rice.col.fg.h;

            text_highlight_color = rice.col.blue.h;
            search_highlight_color = rice.col.yellow.h;
            link_highlight_color = rice.col.blue.h;
            synctex_highlight_color = rice.col.blue.h;

            ui_background_color = rice.col.bg.h;
            ui_text_color = rice.col.fg.h;

            ui_selected_background_color = rice.col.blue.h;
            ui_selected_text_color = rice.col.bg.h;

            status_bar_color = rice.col.black.h;
            status_bar_text_color = rice.col.fg.h;
            status_bar_font_size = toString rice.font.code.size;

            highlight_color_r = rice.col.red.h;
            highlight_color_o = rice.col.orange.h;
            highlight_color_y = rice.col.yellow.h;
            highlight_color_g = rice.col.green.h;
            highlight_color_a = rice.col.aqua.h;
            highlight_color_b = rice.col.blue.h;
            highlight_color_p = rice.col.purple.h;
            highlight_color_w = rice.col.fg.h;

            highlight_color_c = rice.col.aqua.h;
            highlight_color_d = rice.col.aqua.h;
            highlight_color_e = rice.col.aqua.h;
            highlight_color_f = rice.col.aqua.h;
            highlight_color_h = rice.col.aqua.h;
            highlight_color_i = rice.col.aqua.h;
            highlight_color_j = rice.col.aqua.h;
            highlight_color_k = rice.col.aqua.h;
            highlight_color_l = rice.col.aqua.h;
            highlight_color_m = rice.col.aqua.h;
            highlight_color_n = rice.col.aqua.h;
            highlight_color_q = rice.col.aqua.h;
            highlight_color_s = rice.col.aqua.h;
            highlight_color_t = rice.col.aqua.h;
            highlight_color_u = rice.col.aqua.h;
            highlight_color_v = rice.col.aqua.h;
            highlight_color_x = rice.col.aqua.h;
            highlight_color_z = rice.col.aqua.h;
        };
    };
}
