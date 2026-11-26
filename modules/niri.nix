{ pkgs, ... }:

{
  # Reusable baseline for both the live ISO and a future installed system.
  programs.niri.enable = true;
  programs.xwayland.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };
}
