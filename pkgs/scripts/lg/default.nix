{ pkgs, ... }: {
    execer = [
        "cannot:${pkgs.procps}/bin/watch"
        "cannot:${pkgs.less}/bin/less"
    ];

    inputs = [
        pkgs.procps
        pkgs.less
    ];
}
