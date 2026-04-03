scriptdir: {
    custom_open = ''%${scriptdir}/opener'';
    custom_wall = ''%wpp desktop "$f"'';
    custom_fullwall = ''$wpp browser "$f" && echo -n "press enter" && read'';

    custom_extract = /* bash */ ''%{{
    x "$f"
    }}'';





    custom_ee = "cd ~";

    custom_eo = /* bash */ ''%lf -remote "send $id cd \"$OLDPWD\""'';

    custom_e = /* bash */ ''%{{
    printf " e "
    read ans
    target="$(xioxide paths "$ans")"
    lf --remote "send $id cd \"$target\""
    }}'';

    custom_h = /* bash */ ''%{{
    printf " h "
    read ans
    target="$(xioxide paths "$ans")"
    lf --remote "send $id \$$EDITOR \"$target\""
    }}'';

    



    custom_mkdir = /* bash */ ''%{{
    printf " dir name: "
    read ans
    mkdir -p "$ans"
    }}'';

    custom_touch = /* bash */ ''%{{
    printf " file name: "
    read ans
    touch "$ans"
    echo -e '\n' > "$ans"
    }}'';

    custom_chmod = /* bash */ ''%{{
    printf " chmod bits: "
    read ans
    for file in "$fx"; do
    chmod "$ans" "$file"
    done
    lf -remote 'send reload'
    }}'';




    custom_drag = /* bash */ ''%{{
    num="$(echo "$fx" | wc -l)"

    if [ "$num" = "1" ]; then
    dragon-drop -T -x "$f" &
    else
    dragon-drop -T -a -x $(echo $fx) &
    fi
    }}'';

    custom_trash =
    let
    file = "\${files%%;*}";
    files = "\${files#*;}";
    in
    /* bash */ ''%{{
    files=$(printf "$fx" | tr '\n' ';')
    while [ "$files" ]; do
    file=${file}

    trash-put "$(basename "$file")"
    if [ "$files" = "$file" ]; then
    files=""
    else
    files="${files}"
    fi
    done
    }}'';
}
