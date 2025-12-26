```sh
apt update && apt install ntfs-3g
```



create a mount point: `mkdir -p /mnt/hdd1`

find the partition: `lsblk`

```sh
NAME        MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
sda           8:0    0  100G  0 disk 
├─sda1        8:1    0   100G  0 part 
```

mount the partition: `mount -t ntfs-3g /dev/sda1 /mnt/hdd1`
unmount the partition: `umount /mnt/hdd1`

get UUID: `blkid /dev/sda1`
add to fstab:
```sh
echo "UUID=YOUR_DRIVE_UUID /mnt/hdd1 ntfs-3g defaults 0 0" >> /etc/fstab
```

echo "UUID=9032FFCE32FFB776 /mnt/hdd1 ntfs-3g defaults 0 0" >> /etc/fstab