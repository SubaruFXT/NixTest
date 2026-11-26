{
  description = "NixOS live ISO with Niri, plus a reusable Niri system module";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs, ... }:
    let
      system = "x86_64-linux";
    in
    {
      nixosConfigurations.niri-iso = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [ ./hosts/iso.nix ];
      };

      packages.${system}.iso =
        self.nixosConfigurations.niri-iso.config.system.build.isoImage;

      packages.${system}.default = self.packages.${system}.iso;
    };
}
