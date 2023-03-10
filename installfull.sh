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

    # Assign the package list based on the installation type
    case "$INSTALLTYPE" in
        1)
            PACKAGES="htop nano neovim nmon nmtui py ipconfig clamav"
            ;;
        2)
            PACKAGES="htop nano neovim nmon nmtui py ipconfig openbox* obconf clamav alacritty xterm wallch"
            ;;
        3)
            PACKAGES="htop nano neovim nmon nmtui py ipconfig openbox* obconf clamav firefox alacritty xterm nemo* wallch flameshot"
            ;;
        4)
            PACKAGES="htop nano neovim nmon nmtui py ipconfig openbox* obconf clamav firefox alacritty xterm nemo* wallch flameshot gimp kbackup libreoffice bleachbit vlc cheese wine kdenlive"
            ;;
        5)
            PACKAGES="htop nano neovim nmon nmtui py ipconfig clamav firefox alacritty xterm nemo* wallch flameshot kbackup libreoffice bleachbit vlc cheese"
            ;;
        6)
            PACKAGES="htop nano neovim nmon nmtui py ipconfig clamav firefox alacritty xterm nemo* wallch flameshot gimp kbackup libre bleachbit vlc cheese wine kdenlive"
            ;;
        *)
            echo "Invalid option"
            exit
            ;;
    esac

    case "$SYSTEM_TYPE" in
        debian)
            UPDATECMD="apt update -y"
            INSTALLCMD="apt install"
            ;;
        fedora)
            UPDATECMD="dnf update -y"
            INSTALLCMD="dnf install"
            ;;
        arch)
            UPDATECMD="pacman -Syu -y"
            INSTALLCMD="pacman -S"
            ;;
    esac

    # Run the installation and update commands with sudo
    sudo $UPDATECMD
    sudo $INSTALLCMD $PACKAGES -y


-y
fi
