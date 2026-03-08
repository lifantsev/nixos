{ ... }: {
    plugin.enable = true;

    remap = [{
        mode = "n";
        key = "<leader>u";
        action = "<CMD>UndotreeToggle<CR><CMD>UndotreeFocus<CR>";
    }];
}
