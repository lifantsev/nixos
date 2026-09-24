{ stdenv, fetchFromGitHub }: stdenv.mkDerivation {
    pname = "obsidian-catppuccin";
    version = "2.0.3";

    src = fetchFromGitHub {
        owner = "catppuccin";
        repo = "obsidian";
        rev = "2.0.3";
        # you need to get the hash with `nix-prefetch-url --unpack <repo_url>/archive/refs/tags/2.0.3.tar.gz`
        sha256 = "sha256-9fSFj9Tzc2aN9zpG5CyDMngVcwYEppf7MF1ZPUWFyz4=";
    };

    installPhase = ''
        mkdir -p $out
        cp ./manifest.json $out
        cat ${./catppuccin.css} >> ./theme.css
        cp ./theme.css $out
    '';
}
