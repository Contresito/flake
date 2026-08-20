{ pkgs, ... }: {

  stylix.enable = true;
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/eldritch.yaml";
  stylix.cursor = {
    name = "Bibata-Modern-Ice";
    package = pkgs.bibata-cursors;
    size = 24;
  };

  stylix.fonts = {
    sansSerif = {
      package = pkgs.lexend;
      name = "Lexend";
    };
    monospace = {
      package = pkgs.nerd-fonts.caskaydia-mono;
      name = "CaskaydiaMono Nerd Font Mono";
    };
    emoji = {
      package = pkgs.noto-fonts-color-emoji;
      name = "Noto Color Emoji";
    };
  };

  home-manager.users.arepita = {
    stylix.targets.zen-browser.profileNames = [ "default" ];
  };

}
