{
  config,
  secrets,
  lib,
  ...
}:

{
  imports = [ ../../profile/hetzner-x86 ];

  networking.firewall.allowedUDPPorts = [
    config.networking.wireguard.interfaces.wg0.listenPort
  ];

  networking.wireguard = {
    enable = true;
    interfaces.wg0 = {
      ips = [ "10.13.37.1/24" ];
      listenPort = secrets.wg.port;
      privateKeyFile = "/var/lib/wireguard/private";
      # Public key see `secrets/default.nix`
      generatePrivateKeyFile = true;

      peers =
        let
          mapPeer = name: cfg: {
            inherit name;
            inherit (cfg) publicKey;
            allowedIPs = [ "${cfg.ip}/32" ];
            presharedKeyFile = "/var/lib/wireguard/psk-${name}";
          };
        in
        (lib.mapAttrsToList mapPeer secrets.wg.peers);
    };
  };
}
