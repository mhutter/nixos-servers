{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    {
      nixosConfigurations = {
        "nix-cache" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [ ./hosts/nix-cache ];
          specialArgs = {
            secrets = import ./secrets.nix;
            username = "mh";
          };
        };
      };
    };
}
