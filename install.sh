#!/bin/bash

# Check if the script is running with root privileges
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root." >&2
    exit 1
fi

# Update first
apt-get update

# Set up screen
apt-get install -y screen
echo "caption always \"%{= kw}%-w%{= kG}%{+b}[%n %t]%{-b}%{= kw}%+w %= [%l] %0c:%s %{-}\"
startup_message off" >> ~/.screenrc

mkdir /mnt/hdd1

# Setting up Samba home folder
apt-get install -y samba

# Add Samba configuration for home folder
echo "[$HOSTNAME-home]
 comment=$HOSTNAME-home
 path=/home/$USER
 browseable=yes
 writeable=yes
 only guest=no
 create mask=0740
 directory mask=0750
 public=no

[$HOSTNAME]
 comment=$HOSTNAME-public
 path=/mnt/hdd1/public
 browseable=yes
 only guest=no
 create mask=0740
 directory mask=0750
 public=yes" >> /etc/samba/smb.conf

# Set Samba user
smbpasswd -a $USER

echo "Samba configuration finished."

# Install Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh

exit
