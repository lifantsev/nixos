{ rice, ... }: {
    plugin.enable = true;
    plugin.settings = {
        cmdline = {
            enabled = true;
            view = "cmdline";
            format = {
                cmdline.icon     = " >";
                search_down.icon = " /";
                search_up.icon   = " \\";

                help.pattern   = "";
                filter.pattern = "";
                lua.pattern    = "";
            };
        };

        # TODO see what dice.com is for interviewing/resume

        messages.enabled = true; # redirect notify, fn.confirm etc

        popupmenu.enabled = false; # cmdline completion
        commands.enabled = false;
        notify.enabled = false; # enable nvim-notify backend

        lsp = {
            progress.enabled = false;
            hover.enabled = false;
            signature.enabled = false;
            message.enabled = false;
        };

        health.checker = false;

        # https://github.com/folke/noice.nvim/blob/main/lua/noice/config/views.lua
        views = {
            mini = {
                timeout = 3000; # ms
                border.padding = [ 0 1 ];
                win_options.winhighlight.Normal = "Normal";
            };
            confirm = { # vim.fn.confirm
                position.row = 10;
                border = {
                    style = "single";
                    text.top = "";
                };
                win_options.winhighlight = {
                    Normal = "Normal";
                    FloatTitle = "FloatTitle";
                    FloatBorder = "FloatBorder";
                };
            };
            vsplit = {
                enter = true;
                size = "40%";
            };
        };

        # https://github.com/folke/noice.nvim/blob/main/lua/noice/config/format.lua
        format = {
            default = [ "{title} " "{message}" ];
        };

        # routes
        routes = [
            {
                view = "vsplit";
                filter = {  
                    event = "msg_show";  
                    min_height = 15; # linecount
                };
            }
        ];
    };

    lua = with rice.col; /*lua*/ ''
        vim.api.nvim_set_hl(0, 'NoiceCmdlineIcon', { fg = '${mg.h}' })
        vim.api.nvim_set_hl(0, 'NoiceFormatConfirm', { bg = 0 })
        vim.api.nvim_set_hl(0, 'NoiceFormatConfirmDefault', { bg = 0 })

        vim.api.nvim_set_hl(0, 'NoiceCmdlineIconSearch', { link = 'NoiceCmdlineIcon' })
    '';
}
