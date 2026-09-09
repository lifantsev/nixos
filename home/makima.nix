# only configuring makima here, the service is installed in config/keyremap.nix
{ pkgs, lib, ... }@args: let
        mkkey = k: "KEY_${lib.toUpper k}";
        strwrap = s: "\"${s}\"";
        mk_keysin = x: x |> map mkkey |> lib.concatStringsSep "-";
        mk_keysout = x: x |> map mkkey |> map strwrap |> lib.concatStringsSep ", ";

        convert = modsin: modsout: _keys: let
            keys = if builtins.typeOf _keys == "list"
                   then map (e: { name = e; value = e; }) _keys
                   else lib.attrsToList _keys;
        in keys |> map (attrs: let keysout = modsout
                         ++ (if builtins.typeOf attrs.value == "list" then attrs.value else [attrs.value]);
                   in "${mk_keysin (modsin ++ [attrs.name])} = [ ${mk_keysout keysout} ]")
                |> lib.concatStringsSep "\n";

        Apple-SPI-Keyboard = /*toml*/ ''
        KEY_LEFTALT-KEY_N = [ "KEY_LEFT" ]
        KEY_LEFTALT-KEY_A = [ "KEY_UP" ]
        KEY_LEFTALT-KEY_I = [ "KEY_DOWN" ]
        KEY_LEFTALT-KEY_O = [ "KEY_RIGHT" ]

        KEY_LEFTALT-KEY_LEFTSHIFT-KEY_A = [ "KEY_PAGEUP" ]
        KEY_LEFTALT-KEY_LEFTSHIFT-KEY_I = [ "KEY_PAGEDOWN" ]

        KEY_LEFTALT-KEY_G = [ "KEY_END" ]
        KEY_LEFTALT-KEY_LEFTSHIFT-KEY_G = [ "KEY_HOME" ]
        '';
in {
    xdg.configFile."makima/Apple SPI Keyboard.toml".text = /*toml*/ ''
        [remap]
        ${Apple-SPI-Keyboard}
    '';

    xdg.configFile."makima/Apple SPI Keyboard::zen-beta.toml".text = let
        allbut = [ # all keys except those bound specially
            "b" "c" "f" "g" "h" "j" "k" "l" "m" "n" 
            "o" "q" "r" "s" "t" "u" "v" "w" "x" "y" "z"
            "space" "minus" "equal" "slash"
        ];

        allkeys = allbut ++ [ "a" "i" "d" "e" "p" ]; # adding back all keys with special binds

        nirispawn = cmd: /*sh*/ ''
            export NIRI_SOCKET="$(find /run/user/*/niri* | head -n 1)"
            ${pkgs.niri}/bin/niri msg action spawn -- ${cmd}
        '';

        focus-first-field = pkgs.writeShellScriptBin "focus-first-field" ''
            ${pkgs.wtype}/bin/wtype -M ctrl -M shift L -m shift -m ctrl # focus first field
        '';

        browseshell = pkgs.writeShellScriptBin "browseshell" (nirispawn "browseshell");

        pass-autotype = pkgs.writeShellScriptBin "pass-autotype" /*sh*/ ''
            ${nirispawn "${focus-first-field}/bin/focus-first-field"}
            ${nirispawn "pass-autotype"}
        '';
    in /*toml*/ ''
        [remap]

        ${Apple-SPI-Keyboard}

        ${convert ["capslock" "leftalt"] ["leftctrl" "leftshift"] allkeys}

        ${convert ["capslock"] ["leftctrl"] allbut}

        ${convert ["capslock"] ["leftctrl"] { # these are the aforementioned special binds
            d="t"; # just cuz t is hard to reach
            i="tab";
            a= ["leftshift" "tab"];
        }}

        [commands]
        KEY_CAPSLOCK-KEY_E = [ "${browseshell}/bin/browseshell" ]
        KEY_CAPSLOCK-KEY_P = [ "${pass-autotype}/bin/pass-autotype" ]
    '';
        # KEY_CAPSLOCK-KEY_E = [ "browseshell" ]
}
