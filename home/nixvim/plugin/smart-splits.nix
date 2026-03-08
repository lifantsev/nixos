{ ... }: {
    plugin.enable = true;

    remap = let
        bind = direction: {
            mode = [ "n" "t" ];
            key = "<s-${direction}>";
            action.__raw = /*lua*/ ''
                function()
                    require('smart-splits').resize_${direction}(1)
                    require('bufresize').register()
                end
            '';
        };
    in [
        (bind "left")
        (bind "up")
        (bind "down")
        (bind "right")
    ];
}
