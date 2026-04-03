{
    settings = { # same tree as running ':set' from inside qb
        new_instance_open_target = "tab"; # prevents config-source from raising focus, see https://l.opnxng.com/r/qutebrowser/comments/mavj50/how_to_configsource_from_terminal_without_raising/
        messages.timeout = 1000;
        fonts.default_size = "11pt";
        fonts.default_family = "serif";
        zoom.default = 110;
        qt.highdpi = true;

        # content.headers.user_agent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"; # btw there are variables like {os_info} u can use
        content.headers.user_agent = "Mozilla/5.0 ({os_info}; rv:135.0) Gecko/20100101 Firefox/135";
        content.pdfjs = true; # view pdf files in browser
        content.autoplay = false; # video autoplay

        hints = {
            border = "none";
            chars = "rsthnaio";
            radius = 1;
        };

        completion = {
            height = "30%";
            scrollbar = {padding=0; width=0;};
            shrink = true;
        };

        downloads = {
            remove_finished = 3000;
        };

        tabs = {
            position = "left";

            width = "13%";
            indicator.width = 0;
            last_close = "close";
            tooltips = false;
            mousewheel_switching = false;
            title = {
                elide = "none";
                format = "{audio}{current_title}";
            };
        };

        statusbar = {
            position = "bottom";
            show = "always";
        };

        url = {
            default_page = "about:blank";
            start_pages = "en.wikipedia.org/wiki/special:random";
            # everynoise.com
            # catppuccin.com
            # clockie.app
        };
    };

    extraConfig = /* py */ ''
        n = 4
        c.tabs.padding = {'bottom': n, 'top': n, 'left': n, 'right': n}

        c.statusbar.widgets = ['keypress', 'search_match', 'url', 'progress']
    '';
}

