{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      username = "mh";

      # Generate a nixosSystem config for a given host name
      mkHost =
        name:
        nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            # set the hostname
            ({ networking.hostName = name; })
            # Include host-specific configuration
            (./hosts/${name})
          ];
          specialArgs = {
            inherit username;
            secrets = import ./secrets name;
            configPath = self.outPath;
          };
        };
    in
    {
      nixosConfigurations = {
        # This is a barebones "template" configuration that can be used to
        # bootstrap new systems, or create images.
        "template-hcloud-x86" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [ ./profile/hetzner-x86 ];
          specialArgs = {
            inherit username;
            secrets = { };
          };
        };
      }
      // nixpkgs.lib.genAttrs [ "bastion" "nix-cache" ] mkHost;
    };
}
