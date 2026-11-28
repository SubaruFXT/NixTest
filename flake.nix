{
  description = "Minimal custom NixOS live ISO with Niri";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
    in
    {
      nixosConfigurations.iso = nixpkgs.lib.nixosSystem {
        inherit system;

        modules = [
          ./iso.nix
        ];
      };

      packages.${system} =
        let
          iso = self.nixosConfigurations.iso.config.system.build.isoImage;
        in
        {
          inherit iso;
          default = iso;
        };
    };
}
