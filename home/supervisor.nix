{ ... }: {
    programs.supervisor  = {
        enable = true;
        updateloop.use = "niri";

        # TODO make this easier to read (with helper function)
        config = {
            browser = {
                instagram = [
                    "\\(\\(.*www\\.instagram\\.com\\/\\)\\)"
                    "\\(\\(.*www\\.instagram\\.com\\/reels.*\\)\\)"
                ];
                yt_home = "\\(\\(.*www\\.youtube\\.com\\/\\)\\)";
                yt_search = "\\(\\(.*www\\.youtube\\.com\\/results.*\\)\\)";
                yt_watch = {
                    match = "\\(\\(.*www\\.youtube\\.com\\/watch.*\\)\\)";
                    exclude = [
                        "[Mm]usic" # exclude music
                        "[Ss]ong"
                        "[Tt]rack"
                        "[Bb]eat"
                        "[Pp]iano"
                        "[Aa]nimenz"
                        "[Mm]ix"
                        "[Oo]ST" "OST"
                        "[0-9] [Hh]our"
                    ];
                };
                games = [
                    "\\[www\\.chess\\.com\\]"
                    "\\[www\\.slither\\.io\\]"
                ];

                search = "\\[www\\.google\\.com\\]";
                google = [
                    "\\[docs\\.google\\.com\\]"
                    "\\[tasks\\.google\\.com\\]"
                    "\\[calendar\\.google\\.com\\]"
                ];

                school = [
                    "\\[bruinlearn\\.ucla\\.edu\\]"
                    "\\[my\\.ucla\\.edu\\]"
                    "\\[kudu\\.com\\]"
                ];

                repository = [
                    "\\[github\\.com\\]"
                    "\\[codeberg\\.org\\]"
                    "\\[gitlab\\.com\\]"
                ];
                documentation = [
                    "\\[mynixos\\.com\\]"
                ];
                stackoverflow = [
                    "\\[stackoverflow\\.com\\]"
                ];
            };

            terminal = {
                editor = [
                    "^h$"
                    "^h "
                    "^nvim"
                ];
                files = [
                    "^a$"
                    "^a "
                    "^lf"
                ];
                spotify = "^spotify_player";
            };
            any = {
                late.sh = "[ $(date +%H) -ge 22 ] || [ $(date +%H) -le 4 ]";
                verylate.sh = "[ $(date +%H) -le 4 ]";
            };

            obsidian = "";
            mpv = "";
            sioyek = "";
        };
    };
}
