{
    urls.include = [ "*" ];
    urls.exclude = [ "*docs.google.com/presentation*" ];
            # font-family: monospace, sans-serif !important;
    css = /*css*/ ''
        textarea, body, p, a, div, span, h1, h2, h3, h4, h5, h6, li, td, th, code, pre {
            font-family: serif !important;
        }

        .material-icons, .icon {
            font-family: initial !important;
        }

        .google-material-icons {
            font-family: "Google Material Icons" !important;
        }
    '';
}
