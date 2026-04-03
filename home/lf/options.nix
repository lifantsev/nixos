scriptdir: let
    bold = ''\033[1m'';
    italic = ''\033[3m'';
    inverse = ''\033[7m'';

    red = ''\033[31m'';
    green = ''\033[32m'';
    yellow = ''\033[33m'';
    blue = ''\033[34m'';
    purple = ''\033[35m'';
    aqua = ''\033[36m'';
    fg = ''\033[37m'';
    mg = ''\033[2;37m'';
    na = ''\033[0m'';
in {
    shell = "zsh";
    hidden = true;
    ignorecase = true;
    ifs = ''\n'';
    scrolloff = 3;
    tabstop = 4;
    cursorpreviewfmt = "${bold+italic}>";
    cursorparentfmt = "${bold+italic}>";
    cursoractivefmt = "${bold+italic+inverse}";
    errorfmt = ''${red+italic}'';
    previewer = "${scriptdir}/previewer";
    promptfmt = ''${purple+italic}%d%f${na}'';
    dupfilefmt = ''%f.%n'';
    rulerfmt = ''${mg}%a${na}  |${mg}%p${na}  |\033[7;31m %m ${na}  |\033[7;33m %c ${na}  |\033[7;35m %s ${na}  |\033[7;34m %f ${na}  |${mg+italic} %i / %t${na}'';
    statfmt = ''${aqua+italic}%p${na}| ${green+italic}%u:%g${na}| ${red+italic}%s${na}| ${mg+italic}%t${na}| ${aqua}-> %l${na}'';
    timefmt = ''02.01.2006 @ 15:04'';
    incsearch = true;
    ratios = [ 1 2 3 ];
}
