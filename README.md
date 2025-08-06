# Server NixOS configurations

## How To

### Adding new WireGuard hosts

1. Use `./scripts/wg-rotate-psk.sh ALIAS TARGET` to generate & install a PSK
1. Use `./scripts/wg-rotate-key.sh TARGET` to generate a key and print the public key
1. Add the host to `./secrets/bastion.nix`
1. Configure wireguard on TARGET

## Setup

### Hetzner Cloud

Create the server, mount the NixOS ISO image, reboot.

Via the console, run the setup script:

NOTE: The hcloud console "swallows the shift key", so you may have to manually fix the `:` and `|` characters after pasting.

```sh
curl -sS https://raw.githubusercontent.com/mhutter/nixos-servers/refs/heads/main/setup/hcloud.sh | sudo bash
```

When done, EJECT THE ISO and boot the server.
