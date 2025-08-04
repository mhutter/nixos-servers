# Server NixOS configurations

## Setup

### Partitioning

```sh
parted -s /dev/sda -- mklabel gpt
parted -s /dev/sda -- mkpart ESP fat32 1MB 512MB
parted -s /dev/sda -- mkpart root ext4 512MB 100%
parted -s /dev/sda -- set 1 esp on

mkfs.fat -F 32 -n boot /dev/sda1
mkfs.ext4 -L nixos /dev/sda2

mount /dev/disk/by-label/nixos /mnt
mkdir /mnt/boot
mount -o umask=077 /dev/disk/by-label/boot /mnt/boot
```
