# Mounts my btrfs subvolumes
function mount_subvols() {
  echo mounting root subvolume
  mount -o noatime,compress=lzo,space_cache,discard=async,subvol=@ /dev/nvme0n1p3 /mnt/
  echo creating subvolume directories if not already existing
  mkdir -p /mnt/{boot,home}
  echo mounting home subvolume
  mount -o noatime,compress=lzo,space_cache,discard=async,subvol=@home /dev/nvme0n1p3 /mnt/home
  # mount -o noatime,compress=lzo,space_cache,discard=async,subvol=@.snapshots /dev/nvme0n1p3 /mnt/.snapshots
  echo mouting boot parition
  mount /dev/nvme0n1p1 /mnt/boot
  echo generating fstab
  myfstab="$(genfstab -U /mnt)"
  return $myfstab
}

function create_subvols() {
  echo mounting btrfs
  mount -t btrfs /dev/nvme0n1p3 /mnt
  btrfs su cr /mnt/@
  btrfs su cr /mnt/@home


}



# pacstrap /mnt base linux-zen linux-zen-headers vim amd-ucode btrfs-progs openssh

# genfstab -U /mnt >> /mnt/etc/fstab
