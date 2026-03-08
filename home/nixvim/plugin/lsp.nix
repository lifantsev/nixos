# lspconfig
{ ... }: {
    plugin.enable = true;

    plugin.servers = {
        lua_ls.enable = true;
        nixd.enable = true;
        bashls.enable = true;

        lua_ls.settings.diagnostics.globals = [ "vim" ];
    };

    lua = /*lua*/ ''
        vim.o.signcolumn = "yes"
    '';
}
