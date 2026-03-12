{
    actions = {
        "g a" = "GoToArtist";
        "g b" = "GoToAlbum";
        "g l" = "ToggleLiked";
        "g p" = "AddToPlaylist";
        "g y" = "CopyLink";
    };

    keymaps = {
        # TODO do I A seeking in extra config

        # TRACK NAVIGATION / ACTIONS #
        "space" = "ResumePause";
        "S-space" = "AddSelectedItemToQueue";
        "enter" = "ChooseSelected";

        "n" = "PreviousPage";
        "i" = "SelectNextOrScrollDown";
        "a" = "SelectPreviousOrScrollUp";
        "o" = "ChooseSelected";
        "O" = "AddSelectedItemToQueue";

        "right" = "NextTrack";
        "left" = "PreviousTrack";

        "g g" = "SelectFirstOrScrollToTop";
        "G" = "SelectLastOrScrollToBottom";

        # WINDOW NAVIGATION #
        "tab" = "FocusNextWindow";
        "backtab" = "FocusPreviousWindow";

        "l" = "LibraryPage";
        "L" = "LikedTrackPage";
        "C-l" = "LyricsPage";
        "q" = "Queue";
        "h" = "SearchPage";

        "y" = "CurrentlyPlayingContextPage";
        "F" = "CurrentlyPlayingContextPage";
        "f" = "JumpToCurrentTrackInContext";

        # MISC ACTIONS #
        "e" = "Repeat";
        "s" = "Shuffle";
        "m" = "Mute";
        "p" = "OpenSpotifyLinkFromClipboard";
        "r" = "RefreshPlayback";
        "R" = "RestartIntegratedClient";

        "; n" = "Quit";
        "esc" = "ClosePopup";
        "/" = "Search";
        "?" = "OpenCommandHelp";

        # SORTING #
        "z n" = "SortTrackByTitle";
        "z a" = "SortTrackByArtists";
        "z b" = "SortTrackByAlbum";
        "z d" = "SortTrackByAddedDate";
        "z t" = "SortTrackByDuration";
        "z z" = "SortLibraryAlphabetically";
        "z r" = "ReverseOrder";
    };
}
