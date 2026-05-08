{ lib, ... }@args: with builtins; let
    combineAttrsList = lib.zipAttrsWith (k: vals:
        if lib.all lib.isAttrs vals then
            combineAttrsList vals
        else if lib.all lib.isString vals then
            lib.concatStringsSep "\n" vals
        else if length vals > 1 then
            throw "non-string non-attrs value '${key}' defined in multiple places (${toString vals})"
        else head vals
    );

    encodeAttrsToStr = list: list |> lib.mapAttrsToList (k: val:
        if lib.isAttrs val then ''
            ${k} {
            ${encodeAttrsToStr val}
            }
        ''
        else if lib.isString val then
            "${k} ${val}"
        else if lib.isInt val || lib.isFloat val then
            "${k} ${toString val}"
        else if k == "enable" && lib.isBool val then
            if val then "on" else "off"
        else throw "key '${k}' defined set to an unsupported type '${typeOf val}'"
    ) |> lib.concatStringsSep "\n";

    args' = args // { quot = s: "\"${s}\""; };

    r = readDir ./.
    |> attrNames
    |> filter (n: n != "default.nix")
    |> map (n: ./. + "/${n}")
    |> (l: let
        nix = l
            |> filter (lib.hasSuffix ".nix")
            |> map (f: import f args')
            |> combineAttrsList
            |> encodeAttrsToStr;
        kdl = l
            |> filter (lib.hasSuffix ".kdl")
            |> map readFile;
    in kdl ++ [nix])
    |> lib.concatStringsSep "\n";
    in r

