#!/bin/bash

TUI="htop nano neovim nmon nmtui py ipconfig clamav"
BASICWM="htop nano neovim nmon nmtui py ipconfig openbox* obconf clamav alacritty xterm wallch"
ADVANCEDWM="htop nano neovim nmon nmtui py ipconfig openbox* obconf clamav firefox alacritty xterm nemo* wallch flameshot"
FULLWM="htop nano neovim nmon nmtui py ipconfig openbox* obconf clamav firefox alacritty xterm nemo* wallch flameshot gimp kbackup libreoffice bleachbit vlc cheese wine kdenlive"
BASICDE="htop nano neovim nmon nmtui py ipconfig $DE obconf clamav firefox alacritty xterm nemo* wallch flameshot kbackup libreoffice bleachbit vlc cheese"
FULLDE="htop nano neovim nmon nmtui py ipconfig $DE obconf clamav firefox alacritty xterm nemo* wallch flameshot gimp kbackup libre bleachbit vlc cheese wine kdenlive"

#!/bin/bash
echo "This tool is to fully install all necessary tools for a Linux system to operate. This assumes you have a standard system package manager (apt, dnf, or pacman), and an internet connection. I might make one that installs from source."

# Prompt the user to confirm whether they want to continue
echo "Do you wish to continue? Y/N"
read YN

# Use an if statement to check the user's response
if [ "$YN" = "N" ]; then
    exit
elif [ "$YN" = "Y" ]; then
    # Detect system type
    if command -v apt >/dev/null 2>&1; then
        SYSTEM_TYPE="debian" 
    elif command -v dnf >/dev/null 2>&1; then
        SYSTEM_TYPE="fedora"
    elif command -v pacman >/dev/null 2>&1; then
        SYSTEM_TYPE="arch"
    else
        SYSTEM_TYPE="unknown"
    fi

    echo "System type detected: $SYSTEM_TYPE"

    # Use another if statement to handle unknown system types
    if [ "$SYSTEM_TYPE" = "unknown" ]; then
        echo "Sorry, I do not have a tool yet for unknown systems without a package manager."
        exit
    fi

    # Prompt the user to select an installation type
    echo "Do you want an upgraded terminal, basic window manager, advanced window manager, basic desktop environment, or full desktop environment? 1/2/3/4/5"
    read INSTALLTYPE

    # Use a case statement to set the installation command based on the system type and installation type
    case "$SYSTEM_TYPE" in
        debian)
            INSTALLCMD="apt install"
            ;;
        fedora)
            INSTALLCMD="dnf install"
            ;;
        arch)
            INSTALLCMD="pacman -S"
            ;;
    esac

    # Handle desktop environment installations
    if [ "$INSTALLTYPE" = "5" ] || [ "$INSTALLTYPE" = "6" ]; then
        echo "What desktop environment would you like? Input the name in lowercase if you think it is in your package manager, if not; you'll have to compile it. 1/2/3/4/5"
        read DE
        # Add the DE name to the installation command
        INSTALLCMD="$INSTALLCMD $DE"
    fi

if ["$INSTALLTYPE" = "1"]; then
["$INSTALLTYPE" = $TUI]

elif ["$INSTALLTYPE" = "2"]; then
["$INSTALLTYPE" = $BASICWM]


elif ["$INSTALLTYPE" = "3"]; then
["$INSTALLTYPE" = $ADVANCEDWM]


elif ["$INSTALLTYPE" = "4"]; then
["$INSTALLTYPE" = $FULLWM]


elif ["$INSTALLTYPE" = "5"]; then
["$INSTALLTYPE" = $BASICDE]


elif ["$INSTALLTYPE" = "6"]; then
["$INSTALLTYPE" = $FULLDE]

fi
    # Run the installation command with sudo
    sudo $INSTALLCMD $INSTALLTYPE
fi
