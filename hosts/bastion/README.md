# Bastion Host using WireGuard

## Host-specific setup

Run AS ROOT

```sh
install -d -m 0700 /var/lib/wireguard
(umask 0077; nix run nixpkgs#wireguard-tools -- genkey > /var/lib/wireguard/private)
```
