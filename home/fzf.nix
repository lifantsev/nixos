{ lib, rice, ... }: with rice.col; {
    home.sessionVariables.FZF_DEFAULT_OPTS
        = lib.mkForce "--scrollbar=' ' --pointer='>' --gutter=' ' --color bg:-1,bg+:-1,fg:${fg.h},fg+:${aqua.h},gutter:-1,header:${red.h},hl:${aqua.h},hl+:${green.h},info:${mg.h},marker:${blue.h},pointer:${blue.h},preview-bg:-1,preview-fg:${fg.h},prompt:${mg.h},spinner:${red.h}";

    programs.fzf = {
        enable = true;

        colors = {
            fg = fg.h;
            "fg+" = aqua.h;

            bg = "-1";
            "bg+" = "-1";

            preview-fg = fg.h;
            preview-bg = "-1";

            hl = aqua.h;
            "hl+" = green.h;

            gutter = "-1";
            info = mg.h;
            # border = mg.h;
            # border = "-1";

            prompt = mg.h;
            pointer = blue.h;
            marker = blue.h;

            spinner = red.h;
            header = red.h;
        };
    };
}
