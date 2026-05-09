{ ... }: {
    # TODO set up syncing with icloud
    programs.rclone = {
        enable = false;
        remotes = {
            icloud = {
                config = {
                    type = "asd";
                };
            };
        };
    };
}
