{ pkgs, ... }: {

  stylix.enable = true;
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/soft-server.yaml";
  stylix.cursor = {
    name = "Bibata-Modern-Ice";
    package = pkgs.bibata-cursors;
    size = 24;
  };

  home-manager.users.arepita = {
    stylix.targets.zed.enable = true;
    stylix.targets.zed.colors.enable = true;
    stylix.targets.zen-browser.profileNames = [ "default" ];
  };

}
