## Completely Remove Ubuntu and Disable Dualboot (Windows 10)

#### On BIOS
- Give priority to Windows boot manager.

#### On Windows

##### Edit EFI system partition (for UEFI boot mode)
- Launch "cmd" in supervisor mode
```bat
cd C:\
rem check ubuntu identifier
bcdedit /enum firmware
rem assume the identifier is {aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee}
bcdedit /delete {aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee}
rem confirm if the ubuntu firmware app has been removed
bcdedit /enum firmware

diskpart
```

```diskpart
list disk
rem assume the target disk id is 0
sel disk 0

list vol
rem assume the target volume id is 1
sel vol 1

assign letter=Z:
exit
```

```bat
cd /d Z:
cd EFI
rem confirm if directory "ubuntu" exists.
dir
rem remove it
rmdir /S ubuntu
rem confirm if directory "ubuntu" has been removed.
dir
exit
```

##### Partition settings
- Launch "Disk Management" (Built-in) 
or
"MiniTool Partition Wizard Free Edition" from https://www.gigafree.net/system/drive/MiniToolPartitionWizardFree.html .
- Delete the Ubuntu partition.