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

  # NetworkManager provides nmtui and nmcli for Wi-Fi and wired networking.
  networking.networkmanager.enable = true;

  # Temporary account for the live ISO.
  users.users.nixos = {
    isNormalUser = true;
    initialHashedPassword = "";
    shell = pkgs.fish;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  programs.fish.enable = true;

  # Automatically log in to the virtual consoles as the live user.
  services.getty.autologinUser = "nixos";

  # Passwordless sudo is appropriate for this disposable live environment.
  security.sudo.wheelNeedsPassword = false;

  system.stateVersion = "26.05";
}
