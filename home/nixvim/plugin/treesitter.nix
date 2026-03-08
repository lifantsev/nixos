{ pkgs, ... }: { plugin = {
    enable = true;
    grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
        json toml yaml xml
        make regex markdown
        vim vimdoc
        bash zsh
        lua
        nix
    ];

    settings = {
        highlight.enable = true;
        indent.enable = true;
        folding.enable = true;
    };
};}
