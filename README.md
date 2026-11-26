# Minimal NixOS Live ISO

A dedicated custom NixOS live ISO for x86_64 systems.

This repository builds the live environment only. Installed desktop and laptop
configurations will live in separate repositories. Home Manager is intentionally
not part of this project.

## Included environment

- Official NixOS `iso-image.nix` base module.
- Niri, using its upstream v26.04 default configuration with one addition:
  `Mod+B` opens the NixOS manual in LibreWolf.
- Alacritty and LibreWolf, both started automatically when the Niri session begins.
- Fish as the live user's login shell.
- Temporary `nixos` account with automatic login on virtual consoles.
- NetworkManager, including `nmtui` for Wi-Fi.
- Redistributable device firmware for broader Wi-Fi and hardware support.
- UEFI, USB, and x86 BIOS boot support.
- `pkgs.linuxPackages_latest` from the locked Nixpkgs revision.

The upstream Niri configuration is kept intact. Its default Waybar startup
command and Fuzzel/Swaylock keybindings remain, but those applications are not
installed by this ISO configuration.

## Build

On an x86_64 Linux system with Nix flakes enabled:

```sh
nix flake lock
nix build .#iso
```

The ISO is written to the path reported by the build command, normally
`result/iso/nixos-niri-x86_64-linux.iso`.

Commit the generated `flake.lock` file so subsequent builds use the same
Nixpkgs revision and package versions.

## USB installation media

Identify the USB device carefully before writing the ISO. Writing to the wrong
device can destroy data. Use your preferred disk-imaging tool.

## Scope

This repository contains only the live ISO. It does not contain installed-system
configurations or Home Manager configuration.
