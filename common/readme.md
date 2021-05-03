## Utility Settings

### Mozc
- Mozc currently works well in default Ubuntu 20.04 LTS.

#### Install Mozc (Ubuntu 18.04 LTS)
```bash
$ tar -xf mozc-2.23.2815.102+dfsg~ut2-20171008d+20200227.tar.xz
$ cd mozc-2.23.2815.102+dfsg~ut2-20171008d+20200227/
$ sed -i s/'const bool kActivatedOnLaunch = false;'/'const bool kActivatedOnLaunch = true;'/g mut/src/unix/ibus/property_handler.cc
$ sudo apt install -y devscripts autoconf automake autopoint autotools-dev build-essential debhelper dh-autoreconf dh-strip-nondeterminism dpkg-dev fcitx-bin fcitx-libs-dev g++ g++-7 gcc gcc-7 gir1.2-fcitx-1.0 gir1.2-gtk-2.0 gir1.2-harfbuzz-0.0 gyp icu-devtools libasan4 libatk1.0-dev libatomic1 libc-dev-bin libc6-dev libcairo-script-interpreter2 libcairo2-dev libcilkrts5 libdbus-1-dev libdrm-dev libegl1-mesa-dev libexpat1-dev libfcitx-config4 libfcitx-core0 libfcitx-gclient1 libfcitx-qt0 libfcitx-utils0 libfile-stripnondeterminism-perl libfontconfig1-dev libfreetype6-dev libgcc-7-dev libgcroots-dev libgcroots0 libgdk-pixbuf2.0-dev libgettextpo0 libgl1-mesa-dev libgles2-mesa-dev libglib2.0-dev libglib2.0-dev-bin libglu1-mesa-dev libglvnd-core-dev libglvnd-dev libgraphite2-dev libgtk2.0-dev libgwengui-cpp0 libgwengui-qt5-0 libgwengui-qt5-dev libgwenhywfar-core-dev libgwenhywfar-data libgwenhywfar60 libharfbuzz-dev libharfbuzz-gobject0 libibus-1.0-dev libice-dev libicu-dev libicu-le-hb-dev libicu-le-hb0 libiculx60 libitm1 liblsan0 libmng2 libmpx2 libopengl0 libpango1.0-dev libpcre16-3 libpcre3-dev libpcre32-3 libpcrecpp0v5 libpixman-1-dev libpng-dev libprotobuf-dev libprotobuf-lite10 libprotoc10 libpthread-stubs0-dev libpython-dev libpython-stdlib libpython2.7-dev libqt4-dbus libqt4-declarative libqt4-network libqt4-script libqt4-sql libqt4-xml libqt4-xmlpatterns libqt5concurrent5 libqt5designer5 libqt5opengl5 libqt5printsupport5 libqt5sql5 libqt5test5 libqt5xml5 libqtcore4 libqtdbus4 libqtgui4 libquadmath0 libqwt-headers libqwt-qt5-6 libqwt-qt5-dev libsigsegv2 libsm-dev libstdc++-7-dev libtool libtsan0 libubsan0 libuim-custom2 libuim-dev libuim-scm0 libuim8 libwayland-bin libwayland-dev libx11-dev libx11-xcb-dev libxau-dev libxcb-dri2-0-dev libxcb-dri3-dev libxcb-glx0-dev libxcb-present-dev libxcb-randr0-dev libxcb-render0-dev libxcb-shape0-dev libxcb-shm0-dev libxcb-sync-dev libxcb-xfixes0-dev libxcb1-dev libxcomposite-dev libxcursor-dev libxdamage-dev libxdmcp-dev libxext-dev libxfixes-dev libxft-dev libxi-dev libxinerama-dev libxml2-utils libxrandr-dev libxrender-dev libxshmfence-dev libxxf86vm-dev libzinnia-dev linux-libc-dev m4 make mesa-common-dev ninja-build pkg-config po-debconf protobuf-compiler python python-dev python-minimal python-pkg-resources python2.7 python2.7-dev python2.7-minimal python3-distutils python3-lib2to3 qdbus qt5-qmake qt5-qmake-bin qtbase5-dev qtbase5-dev-tools qtchooser qtcore4-l10n x11proto-composite-dev x11proto-core-dev x11proto-damage-dev x11proto-dev x11proto-dri2-dev x11proto-fixes-dev x11proto-gl-dev x11proto-input-dev x11proto-randr-dev x11proto-xext-dev x11proto-xf86vidmode-dev x11proto-xinerama-dev xorg-sgml-doctools xtrans-dev zlib1g-dev
$ sudo ./build_mozc_plus_utdict
$ sudo dpkg -i ./mozc-data_*.deb ./mozc-server_*.deb ./mozc-utils-gui_*.deb ./ibus-mozc_*.deb
```

#### GNOME GUI Settings (Ubuntu 20.04 LTS)
(Ctrl-s) Region & Language -> Confirm Ibus -> Add Japanese (Mozc) etc.

#### Trouble Shootings
- Key assignments will be reset to US keys whenever rebooted. =>
  It Seems to be an internal bug. Adding the built-in Japanese (Roman only) at the top of the language list might work.

### SSH settings (Server)

- Install openssh-server
  ```bash
  $ dpkg -l | grep ssh
  # if no name with "openssh-server", run the next line
  $ sudo apt install openssh-server
  $ dpkg -l | grep ssh
  # "openssh-server" should exists
  ```

- Check hostname
  ```bash
  $ ip addr # or ifconfig
  # find the static ipv6 address:
  # inet6 xxxx:xxxx:xxxx:xxxx:xxxx:xxxx:xxxx:xxxx/64 scope global ...
  $ hostname
  # enabled in DNS servers

- Confirm ssh directory
  ````
  $ mkdir -p ~/.ssh
  $ touch ~/.ssh/authorized_keys
  ````

- Create a user
  ````bash
  $ sudo useradd -m [username]
  $ sudo passwd [username]
  # enter new password
  ````

- Delete a user
  ````bash
  $ sudo userdel -r [username]
  # be careful !!! (Do not remove root user)
  ````

- Set a sudo password
  ````bash
  $ sudo -i
  # passwd
  ````

- Make home folder invisible from other users
  ````bash
  $ chmod 700 /home/[my_username]
  ````

### SSH keys
Location:
~/.ssh/

Format in ~/.ssh/config:
````
Host [short name]
    HostName [IP address or domain name]
    User [user name]
    # Port 22
    IdentityFile ~/.ssh/keys/[pem file]
    ServerAliveInterval 60
````

Generate key:
````bash
$ mkdir -p ~/.ssh/keys
$ ssh-keygen -t rsa -b 4096 -f ~/.ssh/keys/[filename_without_extension].pub
$ chmod 600 ~/.ssh/keys/[filename_without_extension].pem
$ cat ~/.ssh/keys/[filename_without_extension].pub | ssh [short name] "cat >> ~/.ssh/authorized_keys"
````

### Device blacklist
Location:
/etc/modproble.d/blacklist.conf

Hint:
blacklist uas
blacklist usb_storage

### C++, update-alternative
````bash
$ sudo apt install -y gcc-10 g++-10
$ gcc-10 --version
$ g++-10 --version
$ sudo update-alternatives --install /usr/bin/gcc gcc `which gcc-10` 1020 # version to int
$ sudo update-alternatives --install /usr/bin/g++ g++ `which g++-10` 1020 # version to int
````

### About shell
````bash
$ echo $SHELL
# /bin/sh
$ chsh -s /bin/bash
$ exit
$ echo $SHELL
# /bin/bash
````

### About time (hardware clock vs system clock)
````bash
$ sudo hwclock -D --systohc --localtime
````

### About network card
- Disable: Windows -> "Device Manager" -> "Network Adapter" -> "Power Management" -> "Wake on Magic Packet from power off state"
