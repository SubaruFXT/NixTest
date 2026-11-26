{ config, lib, pkgs, ... }:

{
  imports = [
    (modulesPath + "/installer/cd-dvd/installation-cd-minimal.nix")
    ../modules/niri.nix
  ];

  networking.hostName = "niri-iso";
  networking.networkmanager.enable = true;

  users.users.nixos = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # This is a throwaway live environment; allow the live user to administer it.
  security.sudo.wheelNeedsPassword = false;

  services.greetd = {
    enable = true;
    settings.default_session = {
      command = "${pkgs.niri}/bin/niri-session";
      user = "nixos";
    };
  };

  environment.systemPackages = with pkgs; [
    foot
    fuzzel
    waybar
  ];

  isoImage.isoName = lib.mkForce "nixos-niri-x86_64-linux.iso";

  system.stateVersion = "25.11";
}
