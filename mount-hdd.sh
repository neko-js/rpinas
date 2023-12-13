#!/bin/sh

# Specify the path to your disk
disk_path="/dev/sda1"

# Get the format of the disk
format=$(blkid -o value -s TYPE $disk_path)

# Mount the disk based on its format
case "$format" in
  ntfs)
    sudo mount -t ntfs-3g $disk_path /mnt/hdd1
    echo "NTFS disk mounted."
    mount -a
    ;;
  exfat)
    sudo mount -t exfat $disk_path /mnt/hdd1
    echo "exFAT disk mounted."
    mount -a
    ;;
  ext*)
    sudo mount $disk_path /mnt/hdd1
    echo "extX disk mounted."
    mount -a
    ;;
  *)
    echo "Unsupported disk format."
    ;;
esac

exit 0
