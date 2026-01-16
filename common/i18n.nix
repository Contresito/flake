{ pkgs, ... }:
{
  # Enable English, Spanish and Japanese keyboard support
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocales = [ "es_AR.UTF-8/UTF-8" ];
    extraLocaleSettings = {
      LC_ADDRESS = "es_AR.UTF-8";
      LC_IDENTIFICATION = "es_AR.UTF-8";
      LC_MEASUREMENT = "es_AR.UTF-8";
      LC_MONETARY = "es_AR.UTF-8";
      LC_NAME = "es_AR.UTF-8";
      LC_NUMERIC = "es_AR.UTF-8";
      LC_PAPER = "es_AR.UTF-8";
      LC_TELEPHONE = "es_AR.UTF-8";
      LC_TIME = "es_AR.UTF-8";
    };
  };

  home-manager.users.arepita.i18n = {
    inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5 = {
        waylandFrontend = true;
        addons = with pkgs; [
          fcitx5-mozc-ut
          kdePackages.fcitx5-qt
        ];
        settings.inputMethod = {
          "Groups/0" = {
            Name = "Default";
            "Default Layout" = "us";
          };
          "Groups/0/Items/0".Name = "keyboard-us";
          "Groups/0/Items/1".Name = "keyboard-latam";
          "Groups/1" = {
            Name = "mozc";
            "Default Layout" = "us";
          };
          "Groups/1/Items/0".Name = "mozc";
          "GroupOrder"."0" = "Default";
        };
        settings.globalOptions = {
          "Hotkey/TriggerKeys"."0" = "Super+space";
          "Hotkey/EnumerateGroupForwardKeys"."0" = "Shift+Super+space";
        };
      };
    };
  };
}
