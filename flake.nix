{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      username = "mh";
      secrets = hostname: import ./secrets hostname;
    in
    {
      nixosConfigurations = {
        "template-hcloud-x86" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [ ./profile/hetzner-x86 ];
          specialArgs = {
            inherit username;
            secrets = { };
          };
        };

        "nix-cache" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [ ./hosts/nix-cache ];
          specialArgs = {
            inherit username;
            secrets = secrets "nix-cache";
          };
        };
      };
    };
}
