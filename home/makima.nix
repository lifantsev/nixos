# only configuring makima here, the service is installed in config/keyremap.nix
{ ... }: {
    xdg.configFile."makima/Apple SPI Keyboard::zen-beta.toml".text = /*toml*/ ''
        [remap]
        KEY_LEFTCTRL-KEY_A = [ "KEY_LEFTCTRL", "KEY_LEFTSHIFT", "KEY_TAB" ]
        KEY_LEFTCTRL-KEY_I = [ "KEY_LEFTCTRL", "KEY_TAB" ]
    '';
}
