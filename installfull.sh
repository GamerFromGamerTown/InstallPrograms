$TUI = "htop nano neovim nmon nmtui py ipconfig clamav"
$BASICWM = "htop nano neovim nmon nmtui py ipconfig openbox* obconf clamav alacritty xterm wallch"
$ADVANCEDWM = "htop nano neovim nmon nmtui py ipconfig openbox* obconf clamav firefox alacritty xterm nemo* wallch flameshot"
$FULLWM = "htop nano neovim nmon nmtui py ipconfig openbox* obconf clamav firefox alacritty xterm nemo* wallch flameshot gimp kbackup libreoffice bleachbit vlc cheese wine kdenlive"
$BASICDE = "htop nano neovim nmon nmtui py ipconfig $DE obconf clamav firefox alacritty xterm nemo* wallch flameshot kbackup libreoffice bleachbit vlc cheese"
$FULLDE = "htop nano neovim nmon nmtui py ipconfig $DE obconf clamav firefox alacritty xterm nemo* wallch flameshot gimp kbackup libreoffice bleachbit vlc cheese wine kdenlive"

echo "This tool is to fully install all necessary tools for a linux system to operate. This assumes you have a standard system package manager (apt, dnf, or pacman), and an internet connection. I might make one that installs from source."
#!/bin/bash
echo "Do you wish to continue? Y/N"
read YN
if [$YN = N] then {exit}
elif [$YN = Y] then
  {
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

echo "System type detected; $SYSTEM_TYPE"
if [$SYSTEM_TYPE = "unknown"] then {echo "Sorry, I do not have a tool yet for unknown systems without a package manager."&&exit}
fi

echo "Do you want an upgraded terminal, basic window manager, advanced window manager, basic desktop environment, or full desktop environment? 1/2/3/4/5"
read $INSTALLTYPE
if [INSTALLTYPE = "4" or "5"] {echo "What DE would you like? KDE, Gnome, XFCE, budgie, cinnamon, or an other one? Input the name in lowercase if you think it is in your package manager, if not; you'll have to compile it."
read $DE
}
