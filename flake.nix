{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      secrets = hostname: import ./secrets hostname;
    in
    {
      nixosConfigurations = {
        "nix-cache" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [ ./hosts/nix-cache ];
          specialArgs = {
            secrets = secrets "nix-cache";
            username = "mh";
          };
        };
      };
    };
}
