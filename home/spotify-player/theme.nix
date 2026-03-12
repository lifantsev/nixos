{ rice, ... }: with rice.col; {
    block_title.fg = t2.h;
    block_title.modifiers = [ "Italic" ];

    playback_track.fg = green.h;
    playback_artists.fg = green.h;
    playback_metadata.fg = t2.h;
    playback_metadata.modifiers = [ "Italic" ];

    current_playing.fg = blue.h;
    selection.modifiers = [ "Bold" "Underlined" ];

    page_desc.fg = red.h;
    page_desc.modifiers = [ "Italic" ];
    table_header.fg = purple.h;
    table_header.modifiers = [ "Italic" ];

    lyrics_played.fg = mg.h;
    lyrics_playing.fg = fg.h;

    playback_progress_bar.fg = "Black";
    playback_progress_bar_unfilled.fg = "Black";

    playlist_desc.fg = t2.h;
    playlist_desc.modifiers = [ "Italic" ];

    secondary_row.fg = t6.h;
}
