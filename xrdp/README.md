# Windows の RDP -> Ubuntu の xrdp

## Install

````bash
$ sudo apt install -y xserver-xorg-input-all xserver-xorg-core xorgxrdp xrdp
````

## Config

### To avoid "Authentication is required to create a color managed device" pop up

- https://www.cagylogic.com/archives/2021/03/23145121/11743.php

````
$ sudo vim /etc/polkit-1/localauthority/50-local.d/45-allow-colord.pkla
[Allow Colord all Users]
Identity=unix-user:*
Action=org.freedesktop.color-manager.create-device;org.freedesktop.color-manager.create-profile;org.freedesktop.color-manager.delete-device;org.freedesktop.color-manager.delete-profile;org.freedesktop.color-manager.modify-device;org.freedesktop.color-manager.modify-profile
ResultAny=no
ResultInactive=no
ResultActive=yes
````


### To kill xrdp after closing RDP (to allow local login for Ubuntu)

- https://askubuntu.com/questions/1054063/local-ubuntu-desktop-cannot-login-after-opened-xrdp-session

````bash
$ sudo vim /etc/xrdp/sesman.ini
````
````diff
- KillDisconnected=false
+ KillDisconnected=1
````