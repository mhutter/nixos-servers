{ ... }:

{
  imports = [ ../../profile/hetzner-x86 ];

  networking = {
    hostName = "nix-cache";
    domain = "mhnet.app";
    firewall.allowedTCPPorts = [
      80
      443
    ];
  };
}
