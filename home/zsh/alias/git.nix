{
    g = "git";
    gd = "gitutils diff";
    gii = "gitutils init";

    ga = "echo 'git add %%% && git status' | yargs";
    gaa = "ga .";
    gau = "ga -u";

    gs = "g status";
    gc = "g commit";
    gco = "g checkout";
    gb = "g branch";
    gl = "g log --oneline";
    gm = "g merge";

    gll = "g pull";
    gsh = "g push";
    gf  = "g fetch";
    gcl = "g clone";

    # TODO figure out if we wanna keep crypt
    cry = "crypt";
    yy = "sshkey && crypt sync";
    ys = "sshkey && crypt status";
    yii = "sshkey && crypt init";
    ycl = "sshkey && crypt clone";

    yll = "sshkey && crypt pull";
    ysh = "sshkey && crypt push";
    yc = "crypt commit";
    yf = "sshkey && crypt fetch";

    ye = "crypt encrypt";
    yd = "crypt decrypt";
}
