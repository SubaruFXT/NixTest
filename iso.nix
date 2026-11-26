{ modulesPath, pkgs, ... }:

{
  imports = [
    (modulesPath + "/installer/cd-dvd/iso-image.nix")
  ];

  # Use the newest kernel package set provided by the pinned Nixpkgs input.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Support UEFI and USB boot. BIOS boot remains enabled by the ISO module's
  # x86_64 default.
  isoImage.makeEfiBootable = true;
  isoImage.makeUsbBootable = true;

  image.fileName = "nixos-niri-x86_64-linux.iso";

  system.stateVersion = "26.05";
}
