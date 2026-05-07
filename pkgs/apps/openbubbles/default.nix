{
lib,
fetchFromGitHub,
flutter,
pkg-config,
gtk3,
# webkit2gtk_4_1,
libsecret
}:
let
    pname = "openbubbles";
    version = "1.15.0+205";

    src = fetchFromGitHub {
        owner = "OpenBubbles";
        repo = "openbubbles-app";
        rev = "v${version}";
        hash = "sha256-E4ncX94sn7FftBAPm075up3XCRHBX2FqwxNeDDSjgiw=";
        # fetchSubmodules = true;
    };
in 
    flutter.buildFlutterApplication {
        inherit pname version src;

        pubspecLock = lib.importJSON ./pubspec.lock.json;

        gitHashes = {
            # cat pubspec.lock.json | jq -r '.packages | to_entries | .[] | select(.value.description | type == "object" and has("url")) | select(.value.description.url | test("github.com")) | .key'
            audio_waveforms = "";
            desktop_webview_auth = "";
            disable_battery_optimization = "";
            firebase_dart = "";
            flutter_isolate = "";
            gesture_x_detector = "";
            local_notifier = "";
            maps_launcher = "";
            permission_handler_windows = "";
            secure_application = "";
            store_checker = "";
            video_thumbnail = "";
        };

        nativeBuildInputs = [ pkg-config ];
        buildInputs = [ gtk3 libsecret ];
    }

# pubspec.lock was taken straight from the github archive, EXCEPT
# this one dependency had to be fixed (it was pointing to a dev's homedirectory)
#
# "telephony_plus": {
#   "dependency": "direct main",
#   "description": {
#     "path": "/home/tae/Downloads/telephony_plus",
#     "relative": false
#   },
#   "source": "path",
#   "version": "0.0.1"
# },
#
# replace with ==>

# "telephony_plus": {
#   "dependency": "direct main",
#   "description": {
#     "path": "telephony_plus",
#     "relative": true
#   },
#   "source": "path",
#   "version": "0.0.1"
# },
