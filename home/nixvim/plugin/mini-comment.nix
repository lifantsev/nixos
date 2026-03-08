{ ... }: {
    # note we disable everything but textobject bind bc we use Comment.nvim
    plugin.enable = false;
    plugin.settings.mappings = {
        textobject = "hc";
        comment = "";
        comment_line = "";
        comment_visual = "";
    };
}
