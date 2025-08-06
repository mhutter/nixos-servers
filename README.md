# Server NixOS configurations

## Setup

### Hetzner Cloud

Create the server, mount the NixOS ISO image, reboot.

Via the console, run the setup script:

NOTE: The hcloud console "swallows the shift key", so you may have to manually fix the `:` and `|` characters after pasting.

```sh
curl -sS https://raw.githubusercontent.com/mhutter/nixos-servers/refs/heads/main/setup/hcloud.sh | sudo bash
```

When done, EJECT THE ISO and boot the server.
