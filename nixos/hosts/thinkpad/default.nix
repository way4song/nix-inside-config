{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/desktop/fonts
  ];

  # ===== Identity =====
  networking.hostName = "thinkpad";

  # ===== system services =====
  services.printing.enable = true;

  # ===== Desktop =====
  services.desktopManager.cosmic.enable = true;
  services.displayManager.cosmic-greeter.enable = true;
  programs.niri.enable = false;
  programs.dms-shell.enable = false;

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

    # Themes
    noctalia-shell

    ];
  
}
