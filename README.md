# NixOS Niri ISO

This flake builds an x86_64 NixOS live ISO that starts directly into a Niri
Wayland session. It also keeps the shared Niri setup in `modules/niri.nix` so a
future installation configuration can reuse it. Hardware-specific and personal
settings are intentionally out of scope for this repository.

## Build

On a NixOS machine, or another Linux system with Nix flakes enabled:

```sh
nix flake lock
nix build .#iso
```

The ISO will be available at `result/iso/nixos-niri-x86_64-linux.iso`.

To write it to a USB drive, first identify the correct device carefully (for
example with `lsblk`), then use a suitable imaging tool. Writing an image to the
wrong device can destroy data.

## Live environment

The ISO uses the standard NixOS minimal installer base, NetworkManager, and an
autologin Niri session for the temporary `nixos` live user. It includes Foot,
Fuzzel, and Waybar. The live user's wheel access is passwordless and is intended
only for this disposable installer environment.

## Future installed systems

The reusable `modules/niri.nix` enables Niri, Xwayland, and the GTK desktop
portal. A later host configuration can import that module and add each machine's
hardware configuration and personal settings separately.

## Reproducibility

After `nix flake lock`, commit `flake.lock` so later ISO builds use the same
pinned Nixpkgs revision. The flake currently follows the Nixpkgs `nixos-unstable`
branch until that lock file is generated and committed.
