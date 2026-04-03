{ rice, ... }: with rice.col; {
    webpage = {
        preferred_color_scheme = "dark";
        darkmode.enabled = true;
    };

    tooltip = { fg=fg.h; bg=bg.h; };
    hints = {
        fg = fg.h;
        bg = black.h;
        match.fg = t6.h;
    };

    messages = let mk = col: { fg = col.h; bg = bg.h; border = "#00000000"; }; in {
        error = mk red;
        warning = mk red;
        info = mk fg;
    };

    prompts = {
        fg = fg.h;
        bg = t1.h;
        border = "#00000000";
        selected = {
            fg = blue.h;
            bg = t1.h;
        };
    };

    downloads = {
        bar.bg = bg.h;
        error = { fg=red.h; bg=bg.h; };
        start = { fg=fg.h; bg=bg.h; };
        stop = { fg=bg.h; bg=blue.h; };
        system = { fg="none"; bg="none"; };
    };

    tabs = let
        b = black.h;
        m = t2.h;
        f = fg.h;
    in {
        bar.bg = b;
        even = { fg = f; bg = b; };
        odd  = { fg = f; bg = b; };
        selected = {
            even = { fg = f; bg = m; };
            odd  = { fg = f; bg = m; };
        };
    };

    completion = {
        category = { fg=green.h; bg=t1.h; border.bottom=t1.h; border.top=t1.h; };
        even.bg = bg.h;
        odd.bg = bg.h;

        fg = fg.h;
        match.fg = blue.h;

        item.selected = {
            bg = t1.h;
            border.bottom = t1.h;
            border.top = t1.h;
            fg = fg.h;
            match.fg = blue.h;
        };
    };

    statusbar = {
        progress.bg = green.h;
        normal =  { fg = fg.h; bg = black.h; };
        command = { fg = fg.h; bg = black.h; };
        insert =  { fg = bg.h; bg = blue.h; };
        url = {
            fg               = green.h;
            success.http.fg  = green.h;
            success.https.fg = green.h;
            error.fg         = red.h;
            warn.fg          = yellow.h;
            hover.fg         = mg.h;
        };
        caret = {
            fg = bg.h;
            bg = purple.h;
            selection = {
                fg = bg.h;
                bg = purple.h;
            };
        };
    };
}
