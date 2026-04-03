{ pkgs, ... }: { plugin = {
    enable = true;
    grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
        json toml yaml xml
        make markdown
        vim vimdoc
        bash zsh regex 
        lua
        nix
    ];

    settings = {
        highlight.enable = true;
        indent.enable = true;
        folding.enable = true;
    };
};}
