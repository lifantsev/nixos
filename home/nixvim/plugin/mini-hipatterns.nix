{ ... }: { plugin = {
    enable = true;
    settings.highlighters = {
        todo = { pattern = "%f[%w]()TODO()%f[%W]"; group = "DiagnosticInfo"; };
        note = { pattern = "%f[%w]()NOTE()%f[%W]"; group = "DiagnosticWarn"; };
        fixme = { pattern = "%f[%w]()FIXME()%f[%W]"; group = "DiagnosticError"; };
        hex_color.__raw = "require('mini.hipatterns').gen_highlighter.hex_color()";
    };
};}
