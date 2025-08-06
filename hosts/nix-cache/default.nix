{ secrets, ... }:

{
  imports = [ ../../profile/hetzner-x86 ];

  networking.wireguard = {
    enable = true;
    interfaces.wg0 = {
      ips = [ "10.13.37.100/24" ];
      privateKeyFile = "/var/lib/wireguard/private";
      generatePrivateKeyFile = true;

      peers = [
        {
          name = "bastion";
          inherit (secrets.wg.bastion) endpoint publicKey;
          allowedIPs = [ "10.13.37.0/24" ];
          presharedKeyFile = "/var/lib/wireguard/presharedkey";
          persistentKeepalive = 25;
        }
      ];
    };
  };
}
