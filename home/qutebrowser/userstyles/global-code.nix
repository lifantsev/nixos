with (import ../../../rice).col; {
    urls.include = [ "*" ];
    css = /*css*/ ''
        code.hljs { background: #0000 !important; font-family: monospace !important; }

        span.hljs-built_in,
        span.hljs-name,
        span.hljs-selector-pseudo,
        xxx { color: ${red.h} !important; font-family: monospace !important; }

        span.hljs-literal,
        xxx { color: ${orange.h} !important; font-family: monospace !important; }

        span.hljs-keyword,
        span.hljs-type,
        span.hljs-function,
        span.hljs-attribute,
        span.hljs-attr,
        span.hljs-selector-attr,
        xxx { color: ${yellow.h} !important; font-family: monospace !important; }

        span.hljs-string,
        xxx { color: ${green.h} !important; font-family: monospace !important; }

        span.hljs-selector-class,
        xxx { color: ${aqua.h} !important; font-family: monospace !important; }

        span.hljs-number,
        xxx { color: ${blue.h} !important; font-family: monospace !important; }

        span.hljs-variable,
        span.hljs-title,
        xxx { color: ${purple.h} !important; font-family: monospace !important; }

        span.hljs-meta,
        span.hljs-comment,
        xxx { color: ${mg.h} !important; font-family: monospace !important; }
    '';
}
