{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    anchal.url = "github:mukhtharcm/anchal-releases";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations.mufeedcm = nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";

      specialArgs = { inherit inputs; };

      modules = [
        ./configuration.nix
      ];
    };
  };
}
