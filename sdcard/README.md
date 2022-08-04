# Operate SD Card on Linux <!-- omit in toc -->

# Table of contents <!-- omit in toc -->

- [Common options](#common-options)
- [Confirm current state](#confirm-current-state)
- [Adjust to GPT](#adjust-to-gpt)
- [Backup partition information](#backup-partition-information)
- [Backup data in partition](#backup-data-in-partition)
- [Erase all data](#erase-all-data)
- [Destory partition information](#destory-partition-information)
- [Restore partition information](#restore-partition-information)
- [Create a partition](#create-a-partition)
- [Build a filesystem in a partition](#build-a-filesystem-in-a-partition)
- [Copy data](#copy-data)
- [Example](#example)

## Common options

- Daily use

  ```bash
  $ DD_COMMONFLAGS="iflag=fullblock oflag=direct conv=fsync status=progress"
  $ dd if=${IF_PATH} of=${OF_PATH} ${DD_COMMONFLAGS}
  ```

  - `bs=128K` etc. may accelerate `dd` transfer.

## Confirm current state

- One can find device file by `lsblk`, `parted -l` or `dmesg` commands.

  ```
  $ SD_CARD=/dev/sdX
  ```

- Check by `sgdisk`

  ```bash
  $ sudo sgdisk -p ${SD_CARD}
  ```

- Check by `fdisk`

  ```bash
  $ sudo fdisk -l ${SD_CARD}
  ```

## Adjust to GPT

- Use `parted` to let the SD card handle GPT (GUID Partition Table)

  ```bash
  $ sudo parted ${SD_CARD} --script -- mklabel gpt
  ```

## Backup partition information

- Use `sgdisk` to backup partition information

  ```bash
  $ sudo sgdisk -b ${PART_BCK} ${SD_CARD}
  ```

## Backup data in partition

- Use `dd` to backup partition

  ```bash
  $ sudo dd if=${SD_CARD}${PART} of=${DATA_BCK}.${PART} ${DD_COMMONFLAGS}
  ```

- Use `dd` to backup whole SD card

  ```bash
  $ sudo dd if=${SD_CARD} of=${DATA_BCK} ${DD_COMMONFLAGS}
  ```

  - GPT is also replaced

## Erase all data

- Use `dd` to write zeros into SD card

  ```bash
  $ sudo dd if=/dev/zero of=${SD_CARD} bs=128K ${DD_COMMONFLAGS}
  ```

  - GPT is included in first partitions. Therefore this operation will also delete GPT.

## Destory partition information

- Use `sgdisk` to destroy partition information

  ```bash
  $ sudo sgdisk -Z ${SD_CARD}
  ```

## Restore partition information

- Use `sgdisk` to restore partition information from backup

  ```bash
  $ sudo sgdisk -l ${PART_BCK} ${SD_CARD}
  ```

## Create a partition

- Use `sgdisk` to create a partition (but the filesystem is not built)

  ```bash
  $ sudo sgdisk -n ${PART}:${START_SECTOR}:${END_SECTOR} -c ${PART}:${ANY_NAME} -t ${PART}:{TYPE_GUID} ${SD_CARD}
  ```

  - Type code can be found in `sgdisk --list-types`. Also it can be directly specified by GUID.
    - For example, a linux data partition is `8300` in type code, `0fc63daf-8483-4772-8e79-3d69d8477de4` in GUID.

## Build a filesystem in a partition

- Format a FAT32 partition

  ```bash
  $ sudo mkfs.vfat -F 32 ${SD_CARD}${PART}
  ```

- Format an ext4 partition

  ```bash
  $ sudo mkfs.ext4 ${SD_CARD}${PART}
  ```

- Note that one should not build filesystem when copying such as `rootfs.ext2`. The filesystem will exist when copied by `dd`.
  ```bash
  $ sudo dd if=${ROOTFS_FILE} of=${SD_CARD}{PART} ${DD_COMMONFLAGS}
  ```

## Copy data

- Direct copy (usually for IPL, `rootfs.ext2`)
  ```bash
  $ sudo dd if=${FILE} of=${SD_CARD}{PART} ${DD_COMMONFLAGS}
  ```

- Mount and copy
  ```bash
  mkdir -p ${MNT_PATH}
  $ sudo mount ${SD_CARD}{PART} ${MNT_PATH}
  $ # copy data
  $ sudo umount ${SD_CARD}{PART} # or sudo umount ${MNT_PATH}
  ```

## Example

- The following script is to backup and quick format the SD Card by FAT32

  ```bash
  SD_CARD=/dev/sdX # Modify here carefully
  sudo parted ${SD_CARD} --script -- mklabel gpt
  sudo sgdisk -p ${SD_CARD}
  ```

  ```bash
  PART=1 # Partition number
  TYPE_GUID="0700" # Microsoft basic data
  SECTOR_SIZE=512 # Sector size
  PERCENT=100 # Use 100% of the remained empty sectors
  MKFS_CMD="mkfs.vfat -F 32" # build FAT32 filesystem

  PART_BCK=partition_info.bck
  DATA_BCK=sdcard.bck

  FIRST_USABLE_SECTOR=$(sudo sgdisk -F ${SD_CARD} | tail -n1)
  START_SECTOR=${FIRST_USABLE_SECTOR}
  LAST_USABLE_SECTOR=$(sudo sgdisk -E ${SD_CARD} | tail -n1)
  END_SECTOR=$(($FIRST_USABLE_SECTOR + ($LAST_USABLE_SECTOR - $FIRST_USABLE_SECTOR) * $PERCENT / 100))

  echo "First usable sector: ${FIRST_USABLE_SECTOR}"
  echo "Last usable sector: ${LAST_USABLE_SECTOR}"
  echo "End sector (${PERCENT}%): ${END_SECTOR}"

  sudo sgdisk -b ${PART_BCK} ${SD_CARD}
  sudo dd if=${SD_CARD} of=${DATA_BCK} ${DD_COMMONFLAGS}
  sudo sgdisk -Z ${SD_CARD}
  sudo sgdisk -n ${PART}:${START_SECTOR}:${END_SECTOR} -t ${PART}:${TYPE_GUID} ${SD_CARD}
  sudo ${MKFS_CMD} ${SD_CARD}${PART}
  ```
