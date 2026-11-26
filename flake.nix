{
  description = "Minimal custom NixOS live ISO with Niri";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
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

      packages.${system}.iso =
        self.nixosConfigurations.iso.config.system.build.isoImage;

      packages.${system}.default = self.packages.${system}.iso;
    };
}
