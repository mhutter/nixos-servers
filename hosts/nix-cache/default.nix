{ ... }:

{
  imports = [ ../../profile/hetzner-x86 ];

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/nixos";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-label/boot";
      fsType = "ext4";
    };
  };

  networking = {
    hostName = "nix-cache";
    domain = "mhnet.app";
    firewall.allowedTCPPorts = [
      80
      443
    ];
  };
}
