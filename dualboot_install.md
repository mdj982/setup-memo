## Setting up Dualboot (Ubuntu 18.04 LTS onto Windows 10)

### On Windows

#### Preparation of a bootable USB device
- Download "ubuntu-18.04.4-desktop-amd64.iso" from official site.
- Download "Universal USB Installer 1.9.8.2" from https://universal-usb-installer.jp.uptodown.com/windows
- Insert an USB device (FAT32 format) and make it to be a bootable device following the instructions.

#### Partition settings
- Launch "Disk Management" (Built-in) 
or
"MiniTool Partition Wizard Free Edition" from https://www.gigafree.net/system/drive/MiniToolPartitionWizardFree.html .
- Make a free-space partition.

### On BIOS
- Check if storage's control mode is AHCI.
- Give priority to the bootable USB device.
- Disable safe mode.

### On USB device
- On GRUB menu,
    - "Try Ubuntu without installing" (18.04 LTS)
    - "Ubuntu" -> "Install" (20.04 LTS)
- Launch the installer on desktop and follow the instruction.

Done.
