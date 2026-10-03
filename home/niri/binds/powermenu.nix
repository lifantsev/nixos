{
    func = { pkgs, ... }: { spawn, ... }: {
        # NOTE requires input.power-key-handling.enable = false;

        default.NONE.XF86PowerOff = spawn "${pkgs.writeShellScriptBin "powermenu" ''
            opts='cancel_suspend_quit_reboot_shutdown' 
            choice="$(echo "$opts" | tr '_' '\n' | "$DMENU_PROGRAM")"

            case "$choice" in
                "shutdown") shutdown now ;;
                "reboot") reboot ;;
                "suspend") systemctl suspend ;;
                "quit") niri msg action quit ;; # maybe add skip-confirmation=true?
            esac
        ''}/bin/powermenu";
    };
}
