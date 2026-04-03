{ dispatch, ... }: let
    open = x: dispatch "workspace ${x}";
    moveto = x: dispatch "movetoworkspace ${x}";
    sendto = x: dispatch "movetoworkspacesilent ${x}";
in {
    main = {
        C = open "r-1";
        Y = open "r+1";
        F = open "previous";

        SHIFT.C = moveto "r-1";
        SHIFT.Y = moveto "r+1";
        SHIFT.F = moveto "previous";

        CTRL.C = sendto "r-1";
        CTRL.Y = sendto "r+1";
        CTRL.F = sendto "previous";
    };
}
