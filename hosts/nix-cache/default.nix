{ config, secrets, ... }:

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

  services.nix-serve = {
    enable = true;
    bindAddress = "127.0.0.1";
    openFirewall = false;
    secretKeyFile = "/var/lib/nix-serve/secret";
  };

  services.nginx = {
    enable = true;
    recommendedTlsSettings = true;
    recommendedProxySettings = true;
    recommendedOptimisation = true;
    recommendedGzipSettings = true;
    recommendedBrotliSettings = true;

    virtualHosts."nix-cache.mhnet.app" = {
      locations."/".proxyPass =
        "http://${config.services.nix-serve.bindAddress}:${toString config.services.nix-serve.port}";
      addSSL = true;
      enableACME = true;
    };
  };

  security.acme = {
    acceptTerms = true;
    defaults.email = secrets.acmeEmail;
  };
}
