#!/bin/bash

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

BASIC="htop firefox git neofetch clamav"
FULL="htop firefox git neofetch LMMS blender wine libreoffice kdenlive gimp code clamav"

# Use the detected system type variable
echo "Detected Linux system: $SYSTEM_TYPE"

echo "This tool is for me and others to install programs of my liking on a Linux system. This assumes you have internet, sudo, and a GUI. Do you wish to proceed? (Y/N)"
read YN

if [ "$YN" = "N" ]; then
  exit
else
  # If Debian
  if [ "$SYSTEM_TYPE" = "debian" ]; then
    sudo apt update
    sudo apt install -y software-properties-common
    sudo add-apt-repository universe
    sudo apt update -y
    sudo apt upgrade -y
    echo "Do you want a full programs suite (e.g. blender, gimp, etc.) or a basic suite (e.g. htop, neofetch, firefox)? Type 1 for full, and 2 for basic."
    read OPT
    if [ "$OPT" = "1" ]; then
      sudo apt install $FULL -y
    elif [ "$OPT" = "2" ]; then
      sudo apt install $BASIC -y
    else
      exit
    fi
  # If Fedora
  elif [ "$SYSTEM_TYPE" = "fedora" ]; then
    sudo dnf update -y
    sudo dnf install dnf-plugins-core -y
    sudo dnf config-manager --set-enabled powertools
    sudo dnf update -y
    echo "Do you want a full programs suite (e.g. blender, gimp, etc.) or a basic suite (e.g. htop, neofetch, firefox)? Type 1 for full, and 2 for basic."
    read OPT
    if [ "$OPT" = "1" ]; then
      sudo dnf install $FULL -y
    elif [ "$OPT" = "2" ]; then
      sudo dnf install $BASIC -y
    else
      exit
    fi
  # If Arch
  elif [ "$SYSTEM_TYPE" = "arch" ]; then
    sudo pacman -Syu
    sudo pacman -S --needed base-devel
    sudo pacman -S --needed git
    sudo pacman -S --needed yay
    echo "Do you want a full programs suite (e.g. blender, gimp, etc.) or a basic suite (e.g. htop, neofetch, firefox)? Type 1 for full, and 2 for basic."
    read OPT
    if [ "$OPT" = "1" ]; then
      sudo pacman -S $FULL
    elif [ "$OPT" = "2" ]; then
      sudo pacman -S $BASIC
    else
      exit
      elif [ "$SYSTEM_TYPE" = "unknown" ]; then
      echo "System type not found; sorry!"
      sleep 3
      exit
    
    fi
  fi
fi

sleep 3
clear
sleep 1
echo "Hope this helped!"
