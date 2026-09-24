# https://github.com/philpalmieri/obsidian-taskgregator/releases/tag/2.5.0
{ stdenv, fetchurl }: stdenv.mkDerivation {
    pname = "obsidian-taskgregator";
    version = "2.5.0";

    dontUnpack = true;

    mainjs = fetchurl {
        url = "https://github.com/philpalmieri/obsidian-taskgregator/releases/download/2.5.0/main.js";
        hash = "sha256-dlIpwwioRoP017Exql+yOmgBBgjVs0lTmecVR4HqPqs=";
    };

    manifestjson = fetchurl {
        url = "https://github.com/philpalmieri/obsidian-taskgregator/releases/download/2.5.0/manifest.json";
        hash = "sha256-v/A455Zn5VcHCsLFm8Zya78QL4QIPXY2uHGUaWzz2rk=1ffsydn6k53ip0v7cg88hhpi1gvbfb39pif2183mgrb7jvkkiw5z";
    };

    stylescss = fetchurl {
        url = "https://github.com/philpalmieri/obsidian-taskgregator/releases/download/2.5.0/styles.css";
        hash = "sha256-GbRZSMBfn8/W+jn2HtdMp5O2LniLbSvQda/ooXYsOwA=";
    };


    datajson = ./config/taskgregator-data.json;
    
    installPhase = ''
        mkdir -p $out

        cp $mainjs $out/main.js
        cp $manifestjson $out/manifest.json
        cp $stylescss $out/styles.css
        cp $datajson $out/data.json
    '';
}
