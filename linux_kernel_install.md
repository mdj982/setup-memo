## Build and Install Another Linux Kernel (Ubuntu 18.04-LTS)

- Download Latest Stable Kernel from kernel.org
- Assume the downloaded file is linux-5.5.9.tar.xz and is put in ~/

```sh
sudo apt update
sudo apt upgrade
cd ~/
tar -xf linux-5.5.9.tar.xz
cd linux-5.5.9
sudo apt -y install make gcc build-essential libncurses-dev fakeroot kernel-package linux-source libssl-dev bison flex
cp /boot/config-5.3.0-40-generic ./.config # assume current kernel version is 5.3.0-40
make oldconfig
sudo -s
make-kpkg -j 8 --rootcmd fakeroot --initrd kernel_image kernel_headers
cd ..
dpkg -i linux-image-5.5.9_5.5.9-10.00.Custom_amd64.deb
dpkg -i linux-headers-5.5.9_5.5.9-10.00.Custom_amd64.deb
ls /lib/modules % confirm that the new module folder exists
reboot
```