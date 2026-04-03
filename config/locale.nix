{ ... }: {
    time.timeZone = "America/Los_Angeles";

    i18n = let loc = "en_US.UTF-8";
    in {
        defaultLocale = loc;

        extraLocaleSettings = {
            LC_ALL            = loc;
            LC_ADDRESS        = loc;
            LC_IDENTIFICATION = loc;
            LC_MEASUREMENT    = loc;
            LC_MONETARY       = loc;
            LC_NAME           = loc;
            LC_NUMERIC        = loc;
            LC_PAPER          = loc;
            LC_TELEPHONE      = loc;
            LC_TIME           = loc;
        };
    };
}
