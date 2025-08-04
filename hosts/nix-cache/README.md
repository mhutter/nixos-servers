# Nix Binary Cache using nix-serve

## Host-specific setup

```sh
sudo mkdir -p /var/lib/nix-serve
nix-store --generate-binary-cache-key nix-cache.mhnet.app-1 /var/lib/nix-serve/secret /var/lib/nix-serve/public
cat /var/lib/nix-serve/public
```
