# Mounts my btrfs subvolumes
function mount_subvols() {
  echo mounting root subvolume
  mount -o noatime,compress=lzo,space_cache,discard=async,subvol=@ $install_drive /mnt/
  echo creating subvolume directories if not already existing
  mkdir -p /mnt/{boot,home}
  echo mounting home subvolume
  mount -o noatime,compress=lzo,space_cache,discard=async,subvol=@home $install_drive /mnt/home
  # mount -o noatime,compress=lzo,space_cache,discard=async,subvol=@.snapshots /dev/nvme0n1p3 /mnt/.snapshots
  echo "Enter boot partition:"
  read -p "" efi_sp
  echo mouting boot parition $efi_sp
  mount $efi_sp /mnt/boot

  echo "Intel or AMD?"
  read -p "" cpu_platform

  if ["$cpu_platform" == "amd"]; then
    install_amd
  else if ["$cpu_platform" == "intel"]; then
    install_intel
  fi
}

function create_subvols() {
  
  echo mounting btrfs
  echo $install_drive
  mount -t btrfs $install_drive /mnt
  btrfs su cr /mnt/@
  btrfs su cr /mnt/@home

  umount /mnt

  mount_subvols $install_drive
}

function install_amd() {

  pacstrap /mnt base linux-zen linux-zen-headers vim amd-ucode btrfs-progs openssh grub
  
  echo generating fstab
  genfstab -U /mnt >> /mnt/etc/fstab

  arch-chroot /mnt

}


function install_intel() {

  pacstrap /mnt base linux-zen linux-zen-headers vim intel-ucode btrfs-progs openssh grub
  
  echo generating fstab
  genfstab -U /mnt >> /mnt/etc/fstab

  arch-chroot /mnt

}

function start() {
  echo Enter partition to install on: 
  read -p "" install_drive
  echo $install_drive
  create_subvols install_drive
}


start