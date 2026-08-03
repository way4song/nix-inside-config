{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/desktop/fonts
  ];

  # ===== Identity =====
  networking.hostName = "thinkpad";

  # ===== System Services =====
  services.printing.enable = true;

  # ===== Desktop =====
  services.desktopManager.cosmic.enable = true;
  services.displayManager.cosmic-greeter.enable = true;

  programs.niri.enable = true;
  programs.dms-shell.enable = true;

  # Run DMS only in the Niri session.
  systemd.user.services.dms = {
    unitConfig.ConditionEnvironment = "XDG_CURRENT_DESKTOP=niri";
  };

  # ===== Chinese Input =====
  i18n.inputMethod.enable = true;
  i18n.inputMethod.type = "fcitx5";

  i18n.inputMethod.fcitx5.addons = with pkgs; [
    qt6Packages.fcitx5-chinese-addons
    fcitx5-rime
    fcitx5-gtk
  ];

  # ===== Desktop Packages =====
  environment.systemPackages = with pkgs; [

    # Terminal
    ghostty
    wl-clipboard

    # Browsers
    firefox
    google-chrome

    # Productivity
    obsidian
    wechat

    # Creative
    gimp
    inkscape
    kdePackages.kdenlive
    libheif

  ];
}
