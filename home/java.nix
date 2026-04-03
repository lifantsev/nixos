{ pkgs, ... }: {
    programs.java = {
        enable = true;
        package = pkgs.javaPackages.compiler.openjdk8;
    };
}
