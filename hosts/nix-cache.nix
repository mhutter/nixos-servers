{ secrets, configPath, ... }:

{
  imports = [ ../profile/hetzner ];

  system.autoUpgrade = {
    enable = true;
    flake = configPath;
    flags = [
      # Update flake inputs
      "--update-input"
      "nixpkgs"
      "--no-write-lock-file"
      # print build logs
      "-L"
    ];
    dates = "03:00";
    randomizedDelaySec = "60min";
    allowReboot = true;
  };

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
