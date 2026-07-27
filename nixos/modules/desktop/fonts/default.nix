{ pkgs, ... }:

{
  fonts = {
    enableDefaultPackages = true;
    fontDir.enable = true;

    packages = with pkgs; [

      # ===== UI =====
      inter
      ibm-plex
      roboto
      open-sans
      source-sans
      source-serif
      source-code-pro
      liberation_ttf
      dejavu_fonts
      ubuntu-classic

      # ===== Programming =====
      jetbrains-mono
      fira-code
      nerd-fonts.jetbrains-mono
      nerd-fonts.fira-code
      nerd-fonts.symbols-only

      # ===== Chinese =====
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      sarasa-gothic
      lxgw-wenkai
      source-han-sans
      source-han-serif
      wqy_microhei
      wqy_zenhei

      # ===== Emoji & Icons =====
      font-awesome
      noto-fonts-color-emoji
      material-icons
      material-design-icons

      # ===== Compatibility =====
      corefonts
      vista-fonts
    ];

    fontconfig = {
      enable = true;

      defaultFonts = {
        serif = [
          "Noto Serif CJK SC"
          "Noto Serif"
          "Source Han Serif SC"
        ];

        sansSerif = [
          "Noto Sans CJK SC"
          "Noto Sans"
          "Source Han Sans SC"
          "Inter"
        ];

        monospace = [
          "JetBrainsMono Nerd Font"
          "JetBrains Mono"
          "Noto Sans Mono CJK SC"
        ];

        emoji = [
          "Noto Color Emoji"
        ];
      };
    };
  };
}
