{ inputs, rice, lib, pkgs, ... }@args: {
    programs.zen-browser = {
        enable = true;

        policies = {
            DisableAppUpdate = true;
            DisableTelemetry = true;
            DisablePocket = true;
        };

        profiles.default = {
            mods = [
                "642854b5-88b4-4c40-b256-e035532109df" # transparent zen
                "e122b5d9-d385-4bf8-9971-e137809097d0" # no top sites (in search)
            ];

            # extensions are enabled and configured non-declaratively
            extensions.packages = with inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system}; [
                ublock-origin
                clearurls
                zen-internet
                darkreader
                # also
                # select after closing current [https://addons.mozilla.org/en-GB/firefox/addon/select-after-closing-current/]
                # unhook [https://addons.mozilla.org/en-US/firefox/addon/youtube-recommended-videos/]
            ];

            settings = {
                "browser.tabs.allow_transparent_browser" = true; # transparency
                "zen.widget.linux.transparency" = true;
                "zen.view.grey-out-inactive-windows" = false;
                "mod.sameerasw.zen_bg_color_enabled" = true;
                "mod.sameerasw.zen_transparency_color" = "${rice.col.bg.h}e6";
                "mod.sameerasw.zen_tab_switch_anim" = false;

                "browser.theme.toolbar-theme" = 0; # dark mode
                "browser.theme.content-theme" = 0;
                "layout.css.prefers-color-scheme.content-override" = 0;
                "ui.systemUsesDarkTheme" = 1;
                "zen.view.window.scheme" = 0;

                "browser.tabs.insertAfterCurrent" = true;
                "zen.urlbar.behavior" = "float"; # always float

                "toolkit.legacyUserProfileCustomizations.stylesheets" = true; # allow userchrome

                "media.videocontrols.picture-in-picture.enabled" = false; # no PiP

                "devtools.chrome.enabled" = true; # enable remote debug
                "devtools.debugger.remote-enabled" = true;

                "zen.view.experimental-no-window-controls" = true; # disable navbar popup

                "browser.shell.checkDefaultBrowser" = false; # disable default browser shit

                "zen.mediacontrols.enabled" = false; # media player bar
            };

            userChrome = import ./userchrome.nix args;

            # jq -c '.shortcuts[] | {id, key, keycode, action}' ~/.config/zen/default/zen-keyboard-shortcuts.json | fzf
            keyboardShortcutsVersion = 20;
            keyboardShortcuts = let
                processKeyAttrs = a: { id = a.name;  } // (
                    if lib.typeOf a.value == "string" then {
                        key = a.value;
                        modifiers.control = true;
                    } else if lib.typeOf a.value == "list" then { 
                        key = lib.head a.value; 
                        modifiers = (a.value |> lib.tail) ++ ["control"]
                                             |> lib.map (s: { ${s} = true; })
                                             |> lib.mergeAttrsList;
                    } else { disabled = true; }
                );

                in (import ./binds.nix) |> lib.attrsToList |> (lib.map processKeyAttrs);
        };
    };
}
