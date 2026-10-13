{
    func = { pkgs, ... }: { spawn, ... }: {
        # NOTE requires input.power-key-handling.enable = false;

        default.NONE.XF86PowerOff = spawn "${pkgs.writeShellScriptBin "powermenu" ''
            opts='cancel_suspend_quit_reboot_macos_shutdown' 
            choice="$(echo "$opts" | tr '_' '\n' | "$DMENU_PROGRAM")"

            case "$choice" in
                "shutdown") shutdown now ;;
                "reboot") reboot ;;
                "suspend") systemctl suspend ;;
                "quit") niri msg action quit ;; 
                "macos") kitty ${pkgs.writeShellScriptBin "macreboot" ''
                    echo "Rebooting to macos..."
                    sudo asahi-bless --next --set-boot-macos && reboot
                ''}/bin/macreboot ;;
            esac
        ''}/bin/powermenu";
    };
}
