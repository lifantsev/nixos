{
    theme = "main";
    enable_notify = false;
    enable_mouse_scroll_volume = false;

    # NOTE if anyone knows how to disable the image entirely PLEASE let me know
    enable_cover_image_cache = true;
    cover_img_length = 1;
    cover_img_width = 0;
    cover_img_scale = 0.5;
    cover_img_pixels = 0;
    # commented below is setup for 1x1 img
    # cover_img_length = 2;
    # cover_img_width = 1;
    # cover_img_scale = 1.2;
    # cover_img_pixels = 0;

    play_icon = ">";
    liked_icon = ".";
    pause_icon = "";
    explicit_icon = "";

    device.volume = 100;

    layout = {
        playback_window_position = "Bottom";
        playback_window_height = 2;
        library.playlist_percent = 56;
        library.album_percent = 43;
    };

    border_type = "Hidden";
    progress_bar_type = "Line";
    playback_format = "{artists} {track} {metadata}";
    playback_metadata_fields = [ "shuffle" "repeat" ];
}
