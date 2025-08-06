#!/usr/bin/env bash
set -e -u -o pipefail -x

parted -s /dev/sda -- mklabel msdos
parted -s /dev/sda -- mkpart primary ext4 1MB 4GB
parted -s /dev/sda -- set 1 boot on

yes | mkfs.ext4 -L root /dev/sda1 || :
sleep 1
mount /dev/disk/by-label/root /mnt

# TODO: remove `ref` here
nixos-install --no-root-passwd --no-channel-copy --flake 'github:mhutter/nixos-servers?ref=template#template-hcloud-x86'

fstrim /mnt || :
sync
umount /mnt
