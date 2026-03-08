{ rice, ... }: {
    plugin.enable = true;

    plugin.settings = {
        indent.char = "┊";
        indent.highlight = [ "IblChar" ];

        scope.enabled = false;
        exclude.buftypes = [ "terminal" ];
    };

    lua = /*lua*/ ''
        local ibl_hooks = require("ibl.hooks")
        ibl_hooks.register(ibl_hooks.type.HIGHLIGHT_SETUP, function()
            vim.api.nvim_set_hl(0, "IblChar", { fg = "${rice.col.t1.h}" })
        end)
    '';
}
