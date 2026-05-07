# took package from https://github.com/NixOS/nixpkgs/blob/456e8a9468b9d46bd8c9524425026c00745bc4d2/pkgs/by-name/be/beeper/package.nix#L75
# then to port it from x84 to arm:

# replace the appimage url with one like below (i got this from beeper download site)
# https://beeper-desktop.download.beeper.com/builds/Beeper-4.2.808-arm64.AppImage
# then updated the sha hash

# also in the conditional wayland flags (it doesnt seem to respect the hint)
# replace --ozone-platform-hint=auto
# with --ozone-platform=wayland

# i also mucked with the indentation
{
lib,
fetchurl,
appimageTools,
makeWrapper,
writeShellApplication,
curl,
common-updater-scripts,
}:
let
    pname = "beeper";
    version = "4.2.630";
    src = fetchurl {
        url = "https://beeper-desktop.download.beeper.com/builds/Beeper-${version}-arm64.AppImage";
        hash = "sha256-/45ODHkrMRwEXz4M+b0bU9GxXOslWzK9vjmhaKPM+Es=";
    };
    appimageContents = appimageTools.extract {
        inherit pname version src;

        postExtract = ''
      # disable creating a desktop file and icon in the home folder during runtime
      linuxConfigFilename=$out/resources/app/build/main/linux-*.mjs
      echo "export function registerLinuxConfig() {}" > $linuxConfigFilename

      # disable auto update
      sed -i 's/auto_update_disabled:[^,}]*/auto_update_disabled:true/g' $out/resources/app/build/main/main-entry-*.mjs

      # prevent updates
      sed -i -E 's/executeDownload\([^)]+\)\{/executeDownload(){return;/g' $out/resources/app/build/main/main-entry-*.mjs

      # hide version status element on about page otherwise a error message is shown
      sed -i '$ a\.subview-prefs-about > div:nth-child(2) {display: none;}' $out/resources/app/build/renderer/PrefsPanes-*.css
      '';
    };
in
    appimageTools.wrapAppImage {
        inherit pname version;

        src = appimageContents;

        extraPkgs = pkgs: [ pkgs.libsecret ];

        extraInstallCommands = /*sh*/ ''
            install -Dm 644 ${appimageContents}/beepertexts.png $out/share/icons/hicolor/512x512/apps/beepertexts.png
            install -Dm 644 ${appimageContents}/beepertexts.desktop -t $out/share/applications/
            substituteInPlace $out/share/applications/beepertexts.desktop --replace-fail "AppRun" "beeper"

            . ${makeWrapper}/nix-support/setup-hook
            wrapProgram $out/bin/beeper \
                --add-flags "\''${NIXOS_OZONE_WL:+\''${WAYLAND_DISPLAY:+--ozone-platform=wayland --enable-features=WaylandWindowDecorations --enable-wayland-ime=true}} --no-update" \
                --set APPIMAGE beeper \
                --run 'exec >/dev/null' # as recommended in #486164
        '';

        passthru = {
            updateScript = lib.getExe (writeShellApplication {
                name = "update-beeper";
                runtimeInputs = [
                    curl
                    common-updater-scripts
                ];
                text = ''
                    set -o errexit
                    latestLinux="$(curl --silent --output /dev/null --write-out "%{redirect_url}\n" https://api.beeper.com/desktop/download/linux/x64/stable/com.automattic.beeper.desktop)"
                    version="$(echo "$latestLinux" | grep --only-matching --extended-regexp '[0-9]+\.[0-9]+\.[0-9]+')"
                    update-source-version beeper "$version"
                '';
            });

            # needed for nix-update
            inherit src;
        };

        meta = {
            description = "Universal chat app";
            longDescription = ''
      Beeper is a universal chat app. With Beeper, you can send
      and receive messages to friends, family and colleagues on
      many different chat networks.
            '';
            homepage = "https://beeper.com";
            license = lib.licenses.unfree;
            maintainers = with lib.maintainers; [
                jshcmpbll
                zh4ngx
            ];
            platforms = [ "aarch64-linux" ];
        };
    }

