# Raspberry Pi as NAS

Install Raspberry Pi with Pi-hole in Docker.

## Description

This guide provides step-by-step information to set up following services on a *Raspberry Pi*:

|Service|Purpose|
|---|---|
|[SSH](https://www.raspberrypi.com/software/)|Accessing the command line from other devices|
|[Samba](https://github.com/samba-team/samba)|Network storage for easy file system access|
|[Docker](https://github.com/docker)|Run sandboxed applications and servers|
|[PiHole](https://github.com/pi-hole/pi-hole)|DNS with blacklists for ads (like hosts file for Windows)|

## Install OS

Download and install [Raspberry Pi Imager](https://www.raspberrypi.com/software/). Run the installer. Insert the SD card and choose it in the UI. Pick an OS
```
Raspberry Pi OS (Other)
```
```
Raspberry Pi OS Lite (64-bit)
```
In the main menu hit the `Settings icon` on the bottom right. Use the settings in the image below. Skip the wireless connection setting if you are going to connect the Pi to your router via a LAN cable, which is recommended for this.

After that you can hit write. Once that is done, insert the SD card in your Pi and put some power on it.

<img src="https://user-images.githubusercontent.com/40058557/253777732-eb1aaa18-0cd0-4074-b1d2-5ff31f3a26d3.png" width="200"/> <img src="https://user-images.githubusercontent.com/40058557/253777772-a9296563-6efa-45d8-8b36-41d7faad29e2.png" width="200"/> <img src="https://user-images.githubusercontent.com/40058557/253777782-2abeff9c-8e97-49a5-947b-2baf3aeb42c6.png" width="200"/> <image src="https://github.com/neko-js/rpihole/assets/40058557/ad0d1ebe-ed5b-4a33-a087-34dc60cbb236" height="135"> <img src="https://user-images.githubusercontent.com/40058557/253777868-e832d1a3-bcc7-44cd-b45f-d3fa4e1bda54.png" width="200"/>

## Establish SSH Connection

Open [MS Terminal](https://apps.microsoft.com/store/detail/9N0DX20HK701?hl=en-us&gl=US) and type

```
ssh pi@picloud
```

If this does not work, look for the Raspberry Pi IP under network information within your router.

Type `yes`, when asked to trust the fingerprint. Type in password and you will be able to execute commands directly on the Raspberry Pi.

## Terminal 101

|Hotkey|Action|
|---|---|
|Mark text|Copy marked text|
|Right click|Paste from clipboard|
|Up|Last command|
|CTRL+C|Abort current action<br>Exit|
|CTRL+Q|Sometimes exit|

## Install Samba, Docker, Pi-hole

Run the following commands.

This will clone this repo and start the installation script, which will install Samba and Docker. You have to type your password during installation once and retype it again.
```
sudo apt-get install -y git \
&& git clone https://github.com/neko-js/rpinas.git \
&& sudo bash ./rpinas/install.sh
```

Post Docker installation steps:
```
sudo groupadd docker \
; sudo usermod -aG docker $USER \
; newgrp docker \
; sudo chmod 666 /var/run/docker.sock
```

Download and run Pi-hole:
```
cd rpinas \
sudo bash ./post-install.sh
```

## Post Installation Steps

You must set the DNS on your devices to the IP address of the Raspberry Pi.

You will be able to access Pi-hole under the displayed address or under http://picloud.local/admin

## Home Folder Access

You can also access the home folder within your network. The network connection is:
```
\\picloud\picloud-home
```
E.g. go to "This PC" on MS Windows and right click anywhere to create a network connection with this address.
