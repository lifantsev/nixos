{ rice, ... }: {
    # TODO see what this does and enable or delete
    # console = {
    #   font = "Lat2-Terminus16";
    #   keyMap = "us";
    #   useXkbConfig = true; # use xkb.options in tty.
    # };

    boot.initrd.preLVMCommands = with rice.col; /*sh*/ ''
        echo -en "\e]P0${bg.hex}"     #black
        echo -en "\e]P8${t1.hex}"     #darkgrey
        echo -en "\e]P1${brown.hex}"  #darkred
        echo -en "\e]P9${red.hex}"    #red
        echo -en "\e]P2${green.hex}"  #darkgreen
        echo -en "\e]PA${green.hex}"  #green
        echo -en "\e]P3${orange.hex}" #brown
        echo -en "\e]PB${yellow.hex}" #yellow
        echo -en "\e]P4${blue.hex}"   #darkblue
        echo -en "\e]PC${blue.hex}"   #blue
        echo -en "\e]P5${purple.hex}" #darkmagenta
        echo -en "\e]PD${purple.hex}" #magenta
        echo -en "\e]P6${aqua.hex}"   #darkcyan
        echo -en "\e]PE${aqua.hex}"   #cyan
        echo -en "\e]P7${t5.hex}"     #lightgrey
        echo -en "\e]PF${fg.hex}"     #white
        # TODO setfont <font-name>
        clear
    '';
}
