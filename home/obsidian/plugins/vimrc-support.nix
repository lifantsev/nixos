{ stdenv, fetchurl }: stdenv.mkDerivation {
    pname = "obsidian-vimrc-support";
    version = "0.10.2";

    mainjs = fetchurl {
        url = "https://github.com/esm7/obsidian-vimrc-support/releases/download/0.10.2/main.js";
        hash = "sha256-aGNzThnu8lBeBUJQyoIbxTL21iceb1AXKx6KBHNObOI=";
    };

    manifestjson = fetchurl {
        url = "https://github.com/esm7/obsidian-vimrc-support/releases/download/0.10.2/manifest.json";
        hash = "sha256-st5aS+ORuI69konjgVYtFJGlh5ef0Iu9pqf/Ub4n0FY=";
    };

    datajson = ./config/vimrc-support.json;
    vimrc = ./config/vimrc-support.vimrc;

    dontUnpack = true;

    installPhase = ''
        mkdir -p $out
        cp $mainjs $out/main.js
        cp $manifestjson $out/manifest.json
        cp $datajson $out/data.json
        cp $vimrc $out/.vimrc
    '';
}
