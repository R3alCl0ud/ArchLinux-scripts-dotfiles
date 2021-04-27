echo mounting root parition
mount -o noatime,compress=lzo,space_cache,subvol=@ /dev/nvme1n1p3 /mnt/
echo mounting sub volumes
mount -o noatime,compress=lzo,space_cache,subvol=@home /dev/nvme1n1p3 /mnt/home
mount -o noatime,compress=lzo,space_cache,subvol=@srv /dev/nvme1n1p3 /mnt/srv
mount -o noatime,compress=lzo,space_cache,subvol=@tmp /dev/nvme1n1p3 /mnt/tmp
mount -o noatime,compress=lzo,space_cache,subvol=@opt /dev/nvme1n1p3 /mnt/opt
mount -o noatime,compress=lzo,space_cache,subvol=@.snapshots /dev/nvme1n1p3 /mnt/.snapshots
mount -o nodatacow,subvol=@var /dev/nvme1n1p3 /mnt/var
echo mouting boot parition
mount /dev/nvme1n1p1 /mnt/boot
