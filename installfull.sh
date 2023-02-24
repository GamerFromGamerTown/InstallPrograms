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


