{ rice, ... }: {
    plugin.enable = true;

    plugin.settings = {
        options = {
            globalstatus = true;
            icons_enabled = false;
            component_separators = "";
            section_separators = "";
            always_divide_middle = false;

            refresh.statusline = 500;
            refresh.tabline = 700;

            theme = with rice.col; let 
                mkBlock = col: { a = { fg=col.h; gui="italic"; }; };
            in {
                inactive = mkBlock mg;
                normal   = mkBlock t6;
                insert   = mkBlock blue;
                visual   = mkBlock purple;
                command  = mkBlock aqua;
                replace  = mkBlock red;
            };
        };

        tabline = {
            lualine_a = [{
                __unkeyed = "tabs";
                cond.__raw = "function() vim.o.showtabline = 1 return true end"; # force showtabline to be set correctly (only show when >1 tabs)

                mode = 0;
                path = 0;
                use_mode_colors = true;
                show_modified_status = false;
            }];

            lualine_z = [ "branch" ];
        };

        sections = {
            lualine_a = [{
                __unkeyed = "buffers";

                max_length.__raw = "vim.o.columns";
                show_modified_status = false;
                use_mode_colors = true;

                symbols = { modified = ""; alternate_file = ""; directory = ""; };
            }];

            lualine_z = [ "location" ];

            lualine_b = { __empty = null; };
            lualine_c = { __empty = null; };
            lualine_x = { __empty = null; };
            lualine_y = { __empty = null; };
        };
    };
}
