#!/bin/bash
# Ensure the script is run as root
if [ "$EUID" -ne 0 ]; then 
  echo "Please run as root"
  exit
fi

# Update system and install necessary packages
apt update && apt upgrade -y
apt install -y sway firefox-esr lightdm

# Set up the "vm" user (change the password as necessary)
useradd -m vm
echo "vm:password" | chpasswd

# Configure LightDM to auto-login the "vm" user
echo "[Seat:*]
autologin-user=vm
autologin-user-timeout=0
user-session=sway" > /etc/lightdm/lightdm.conf

# Configure Sway to start Firefox on login
echo "exec firefox" > /home/vm/.config/sway/config

# Change ownership of the sway config file to the "vm" user
chown vm:vm /home/vm/.config/sway/config

# Enable and start LightDM
systemctl enable lightdm
systemctl start lightdm

# Script end
echo "Setup complete. The system will now boot into Sway with Firefox on startup."
