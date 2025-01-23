#!/bin/bash

# Update and upgrade the system
echo "Updating and upgrading the system..."
sudo apt update -y && sudo apt upgrade -y

# Disable automatic updates
echo "Disabling automatic updates..."
sudo systemctl disable --now apt-daily.timer
sudo systemctl disable --now apt-daily-upgrade.timer

# Install RustDesk
echo "Installing RustDesk..."
wget https://github.com/rustdesk/rustdesk/releases/download/1.3.7/rustdesk-1.3.7-aarch64.deb -O rustdesk.deb
sudo dpkg -i rustdesk.deb
sudo apt-get install -f -y  # Fix any dependency issues
rm rustdesk.deb  # Clean up the downloaded file

# Install Chromium
echo "Installing Chromium..."
sudo apt install -y chromium-browser

# Change username of the current user
CURRENT_USER=$(whoami)
NEW_USER="BPF"
echo "Changing username from $CURRENT_USER to $NEW_USER..."
sudo usermod -l "$NEW_USER" "$CURRENT_USER"
sudo usermod -d "/home/$NEW_USER" -m "$NEW_USER"

# Change user password
NEW_PASSWORD="olyretail"
echo "Changing password for $NEW_USER..."
echo -e "$NEW_PASSWORD\n$NEW_PASSWORD" | sudo passwd "$NEW_USER"

echo "Script execution completed!"
