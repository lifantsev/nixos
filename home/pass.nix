{ config, pkgs, ...}: {
    programs.password-store = {
        enable = true;
        settings.PASSWORD_STORE_DIR = "${config.home.homeDirectory}/.pass";
        package = pkgs.pass; # can add extensions here, see mynixos
    };
}
