{ ... }: {
    environment = {
        LGENABLE = "1";
        GET_WINDOW_CLASS = "niri msg --json focused-window | jq -r .app_id";
        GET_WINDOW_TITLE = "niri msg --json focused-window | jq -r .title";
    };
}
