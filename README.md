# Minimal NixOS Live ISO

A dedicated, custom NixOS live ISO configuration for x86_64 systems.

This repository is for building the live installer environment only. Installed
desktop and laptop configurations will live in separate repositories. Home
Manager is intentionally not part of this project.

## Design

- Custom ISO built from the official NixOS `iso-image.nix` module.
- Niri as the Wayland compositor.
- Alacritty terminal.
- LibreWolf browser, opening the NixOS manual.
- Fish shell.
- Automatic TTY login followed by a Niri session.
- UEFI, USB, and x86 BIOS boot support.

The configuration is being assembled incrementally. The list above describes
the intended environment; not every component has been configured yet.

## Architecture

The flake targets `x86_64-linux`. The exact Nixpkgs revision is recorded in
`flake.lock` after the lock file is generated and committed.

## Build

Build instructions will be finalized after the ISO configuration is complete
and has been evaluated on the desktop.
