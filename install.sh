function mount() {
  echo mounting root parition
  mount -o noatime,compress=lzo,space_cache,subvol=@ /dev/nvme1n1p3 /mnt/
  echo creating subvolume directories if not already existing
  mkdir -p /mnt/{boot,home,.snapshots}
  echo mounting sub volumes
  mount -o noatime,compress=lzo,space_cache,subvol=@home /dev/nvme1n1p3 /mnt/home
  mount -o noatime,compress=lzo,space_cache,subvol=@.snapshots /dev/nvme1n1p3 /mnt/.snapshots
  echo mouting boot parition
  mount /dev/nvme1n1p1 /mnt/boot
  echo generating fstab
  myfstab="$(genfstab -U /mnt)"
  echo $myfstab
}


pacstrap /mnt base linux-zen linux-zen-headers vim amd-ucode btrfs-progs openssh

genfstab -U /mnt >> /mnt/etc/fstab
