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

  # Include redistributable device firmware, including common Wi-Fi firmware.
  hardware.enableRedistributableFirmware = true;

  # NetworkManager provides nmtui and nmcli for Wi-Fi and wired networking.
  networking.networkmanager.enable = true;

  # Enable SSH access to the live environment, as on the standard installer.
  services.openssh.enable = true;

  # Enable the modern Nix CLI and flake support in the live environment.
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

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

  # Enable Niri without Nautilus as an additional file-manager application.
  programs.niri = {
    enable = true;
    useNautilus = false;
  };

  # Use the upstream Niri default config, with only the requested Mod+B binding.
  environment.etc."niri/config.kdl".source = ./niri-default-config.kdl;

  # Applications and installation/recovery tools requested for the live environment.
  environment.systemPackages = with pkgs; [
    alacritty
    librewolf
    neovim
    parted
    gptfdisk
    e2fsprogs
    btrfs-progs
    efibootmgr
    pciutils
    usbutils
    git
  ];

  # Start Niri from the first virtual console after automatic login.
  programs.fish.loginShellInit = ''
    if test (tty) = /dev/tty1
      exec niri-session -l
    end
  '';

  # Open the terminal and browser after Niri has initialized its graphical
  # session environment and started niri.service.
  # Inherit the full session PATH so sudo, nmtui, and other NixOS commands
  # remain available inside the autostarted terminal.
  systemd.user.services.alacritty-autostart = {
    description = "Open Alacritty at Niri session start";
    after = [ "niri.service" ];
    wantedBy = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];
    enableDefaultPath = false;
    serviceConfig.ExecStart = "${pkgs.alacritty}/bin/alacritty";
  };

  systemd.user.services.librewolf-autostart = {
    description = "Open the NixOS manual in LibreWolf at Niri session start";
    after = [ "niri.service" ];
    wantedBy = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];
    enableDefaultPath = false;
    serviceConfig.ExecStart = "${pkgs.librewolf}/bin/librewolf https://nixos.org/manual/";
  };

  # Automatically log in to the virtual consoles as the live user.
  services.getty.autologinUser = "nixos";

  # Passwordless sudo is appropriate for this disposable live environment.
  security.sudo.wheelNeedsPassword = false;

  system.stateVersion = "26.05";
}
