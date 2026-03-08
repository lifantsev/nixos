{ ... }: {
    # 'hc' comment textobject bind comes from mini.comment
    plugin.enable = true;
    plugin.settings = {
        ignore = "^$";

        extra = {
            above = "gca";
            below = "gci";
            eol = "gco";
        };

        opleader = {
            line = "gc";
            block = "gb";
        };

        # NOTE depends on ts_context_commentstring
        pre_hook = "require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook()";
    };
}
