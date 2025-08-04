# Server NixOS configurations

## Setup

### Hetzner Cloud

Create the server, mount the NixOS ISO image, reboot.

Via the console, set up SSH authorized keys:

```sh
install -d -m 0700 .ssh
curl https://github.com/mhutter.keys -o .ssh/authorized_keys
```

You can now SSH into the server: `ssh nixos@<public IP>`

```sh
# Partitioning
parted -s /dev/sda -- mklabel msdos
parted -s /dev/sda -- mkpart primary ext4 1MB 512MB
parted -s /dev/sda -- set 1 boot on
parted -s /dev/sda -- mkpart primary ext4 512MB 100%

mkfs.ext4 -L boot /dev/sda1
mkfs.ext4 -L nixos /dev/sda2

mount /dev/disk/by-label/nixos /mnt
mkdir /mnt/boot
mount /dev/disk/by-label/boot /mnt/boot
```

Once ready, install NixOS:

```sh
# URL format: github:mhutter/nixos-servers[?ref=<branch/ref>]#<hostname>
nixos-install -j auto --cores 0 --no-root-passwd --flake 'github:mhutter/nixos-servers?ref=dev#nix-cache'
```

(_Sometimes_, nix caches the flake, in that case just use a commit ID instead of a branch name)

When done, sync, unmount the file systems, power off, EJECT THE ISO and boot the server. (Ejecting the ISO before rebooting will cause segfaults when trying to reboot or poweroff)
